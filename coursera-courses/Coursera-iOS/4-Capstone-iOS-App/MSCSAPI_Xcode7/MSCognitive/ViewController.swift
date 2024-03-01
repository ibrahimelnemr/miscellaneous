
import UIKit

// This view controller allows the user to pick an image from their camera roll and have it analyzed.
// The resulting description is shown.

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let SubscriptionKey = "Enter your Microsoft Cognitive Services subscription key here."
    
    @IBOutlet weak var pickButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func pickButtonAction(sender: AnyObject) {
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let client = MSCSAPIClient(subscriptionKey: ViewController.SubscriptionKey)
        
        pickButton.enabled = false
        pickButton.setBackgroundImage(image, forState: .Normal)
        
        self.resultLabel.text = ""
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        client.analyzeImage(image, detectFeatures: [.Adult, .Categories, .Color, .Description, .Faces, .ImageType, .Tags]) { (json, error) in
            self.pickButton.enabled = true
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            guard error == nil else {
                print (error!.localizedDescription)
                self.resultLabel.text = error!.localizedDescription
                return
            }
            guard let data = json else {
                print ("no json data")
                self.resultLabel.text = "no json data"
                return
            }
            
            guard let description = data["description"] as? [String: AnyObject] else {
                guard let message = data["message"] as? String else {
                    return
                }
                self.resultLabel.text = message
                return
            }
            
            guard let captions = description["captions"] as? [AnyObject] else {
                guard let message = data["message"] as? String else {
                    return
                }
                self.resultLabel.text = message
                return
            }
            
            // 'captions' is an array of JSON objects. Each object has a 'text' property with the description text.
            // This function uses the map function to cast the unknown objects as the correct type,
            // then filters out empty strings, then joins the resulting strings  into one string
            // with a newline separator ("\n").
            self.resultLabel.text = captions.map(
                { (($0 as? [String: AnyObject])?["text"] as? String) ?? ""}).filter(
                    { $0 != "" }).joinWithSeparator("\n")
            
        }
        
        
    }
    
    
}

