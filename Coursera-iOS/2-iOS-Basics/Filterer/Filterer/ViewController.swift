// ViewController.swift
import UIKit
import ImageProcessor

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
