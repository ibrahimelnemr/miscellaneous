
// ViewController.swift
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var originalImage: UIImage?
    var filteredImage: UIImage?
    var filterIntensity: Float = 1.0
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet var imageToggle: UIButton!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    let processor = ImageProcessor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageToggle.setTitle("Show Before Image", forState: .Selected)
        
        let image = UIImage(named: "scenery")!
        originalImage = image
        
        var rgbaImage = RGBAImage(image: image)!
        
        applyFilter(&rgbaImage) // Pass rgbaImage by reference
        
        imageView.image = filteredImage
        
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBAction func onImageToggle(sender: UIButton) {
        if sender.selected {
            imageView.image = filteredImage
        } else {
            imageView.image = originalImage
        }
        
        sender.selected = !sender.selected
    }
    
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onFilter(sender: UIButton) {
        if sender.selected {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    @IBAction func onEdit(sender: AnyObject) {
        guard let _ = filterButton.currentTitle else { return }
        hideSecondaryMenu()
        
        let slider = UISlider(frame: CGRect(x: 20, y: self.view.frame.height - 100, width: self.view.frame.width - 40, height: 40))
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = filterIntensity
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), forControlEvents: .ValueChanged)
        self.view.addSubview(slider)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            originalImage = image
            var rgbaImage = RGBAImage(image: image)!
            applyFilter(&rgbaImage) // Pass rgbaImage by reference
            imageView.image = filteredImage
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func applyFilter(inout rgbaImage: RGBAImage) {
        // Call the ImageProcessor to apply the filter
        processor.applyFilter(to: &rgbaImage, filterStrength: 10, filterColor: "Red")
        filteredImage = rgbaImage.toUIImage()
    }
    
    func sliderValueChanged(sender: UISlider) {
        filterIntensity = sender.value
        var rgbaImage = RGBAImage(image: originalImage!)! // Apply filter on the original image
        applyFilter(&rgbaImage) // Pass rgbaImage by reference
        imageView.image = filteredImage
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }
    
    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
        }) { completed in
            if completed == true {
                self.secondaryMenu.removeFromSuperview()
            }
        }
    }
}
enum FilterType: String {
    case brightness = "Brightness"
    case contrast = "Contrast"
}

public class Filter {
    let type: FilterType
    let strength: Int
    
    init(type: FilterType, strength: Int) {
        self.type = type
        self.strength = strength
    }
    
    func apply(inout to pixels: [Pixel]) {
        switch type {
        case .brightness:
            applyBrightness(to: &pixels)
        case .contrast:
            applyContrast(to: &pixels)
        }
    }
    
    private func applyBrightness(inout to pixels: [Pixel]) {
        for i in 0..<pixels.count {
            pixels[i].red = applyFormula(pixels[i].red)
            pixels[i].green = applyFormula(pixels[i].green)
            pixels[i].blue = applyFormula(pixels[i].blue)
        }
    }
    
    private func applyContrast(inout to pixels: [Pixel]) {
        for i in 0..<pixels.count {
            pixels[i].red = applyFormula(pixels[i].red)
            pixels[i].green = applyFormula(pixels[i].green)
            pixels[i].blue = applyFormula(pixels[i].blue)
        }
    }
    
    private func applyFormula(value: UInt8) -> UInt8 {
        let newValue = Int(value) + strength
        return UInt8(max(0, min(255, newValue)))
    }
}

class ImageProcessorTest {
    var filters: [Filter] = []
    
    init() {
        filters = [
        Filter(type: .brightness, strength: 50),
        Filter(type: .contrast, strength: 2)
        ]
    
    }
    
    func applyFilters(inout to myRGBA: RGBAImage) {
        for filter in filters {
            filter.apply(to: &myRGBA.pixels)
        }
    }
    
    func applyFilterByName(inout to myRGBA: RGBAImage, filterName: String) {
        if let filter = filters.first where filter.type.rawValue == filterName {
            filter.apply(to: &myRGBA.pixels)
        } else {
            print("Filter '\(filterName)' not found")
        }
    }
    
    func applyFiltersByName(inout to myRGBA: RGBAImage, filterNames: [String]) {
        for filterName in filterNames {
            if let filter = filters.first where filter.type.rawValue == filterName {
                filter.apply(to: &myRGBA.pixels)
            } else {
                print("Filter '\(filterName)' not found")
            }
        }
    }
}


public class ImageProcessor {
    init() {
        
    }
    
    func applyFilter(inout to myRGBA: RGBAImage, filterStrength: Int, filterColor: String) {
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        
        let count = myRGBA.width * myRGBA.height
        let avgRed = totalRed / count
        let avgGreen = totalGreen / count
        let avgBlue = totalBlue / count
        
        let acceptedColors = [
            "Green",
            "Red",
            "Blue"
        ]
        
        let acceptedStrengths = [1,2,3,4,5,6,7,8,9,10]
        
        if !acceptedColors.contains(filterColor) || !acceptedStrengths.contains(filterStrength) {
            print("Invalid filter or strength value")
            return
        }
        
        if filterColor == "Red" {
            for y in 0..<myRGBA.height {
                for x in 0..<myRGBA.width {
                    let index = y * myRGBA.width + x
                    var pixel = myRGBA.pixels[index]
                    let redDiff = Int(pixel.red) - avgRed
                    if redDiff > 0 {
                        pixel.red = UInt8(max(0, min(255, avgRed + redDiff * filterStrength)))
                        myRGBA.pixels[index] = pixel
                    }
                }
            }
        } else if filterColor == "Blue" {
            for y in 0..<myRGBA.height {
                for x in 0..<myRGBA.width {
                    let index = y * myRGBA.width + x
                    var pixel = myRGBA.pixels[index]
                    let blueDiff = Int(pixel.blue) - avgBlue
                    if blueDiff > 0 {
                        pixel.blue = UInt8(max(0, min(255, avgBlue + blueDiff * filterStrength)))
                        myRGBA.pixels[index] = pixel
                    }
                }
            }
        } else if filterColor == "Green" {
            for y in 0..<myRGBA.height {
                for x in 0..<myRGBA.width {
                    let index = y * myRGBA.width + x
                    var pixel = myRGBA.pixels[index]
                    let greenDiff = Int(pixel.green) - avgGreen
                    if greenDiff > 0 {
                        pixel.green = UInt8(max(0, min(255, avgGreen + greenDiff * filterStrength)))
                        myRGBA.pixels[index] = pixel
                    }
                }
            }
        }
    }
}
