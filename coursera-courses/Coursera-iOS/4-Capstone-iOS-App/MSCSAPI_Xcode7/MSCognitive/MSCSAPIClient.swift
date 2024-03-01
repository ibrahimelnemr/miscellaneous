import UIKit

// Use this String extension method to encode a string to be passed in a URL request.
// When sending a string as a parameter in a URL query, you must replace certain characters with escape sequences.
// This function will return a string that is safe to embed in a URL query.
// It will escape any non-alphanumeric characters, except for the specified exceptions.

extension String {
    func encodedStringForURLEncodedFormData() -> String? {
        let exceptions = "*-._"
        let allowed = NSMutableCharacterSet.alphanumericCharacterSet()
        allowed.addCharactersInString(exceptions)
        
        return stringByAddingPercentEncodingWithAllowedCharacters(allowed)
    }
}

// Use this class to communicate with the Microsoft Cognitive Services API.
// Our sample implementation has one instance method that lets you use MSCS's image analysis service.
// You can find more APIs by browsing the MSCS documentation.
// Use the analyzeImage function as a guide on constructing a request and parsing the returned data.

class MSCSAPIClient {
    
    private let subscriptionKey: String
    
    // enter your MS endpoint base URL here
    static let endpointBaseURL = "https://westcentralus.api.cognitive.microsoft.com/vision/v1.0"
    static let analyzeURL = endpointBaseURL + "/analyze"
    
    enum MSCSAPIClientError: Int {
        case URLError
        case ImageFormatError
        case ImageSizeError
        case ImageDimensionsError
        case JSONFormatError
        case StringEncodingError
        case MissingData
    }
    
    enum FeatureTypes: String {
        case Categories = "Categories"
        case Tags = "Tags"
        case Description = "Description"
        case Faces = "Faces"
        case ImageType = "ImageType"
        case Color = "Color"
        case Adult = "Adult"
    }
    
    // Note a Computer Vision subscription key is required to analyze images with this service.
    // You may need additional subscription keys to access additional services.
    init(subscriptionKey: String) {
        self.subscriptionKey = subscriptionKey
    }
    
    // Extract a set of visual features based on image content.
    // See here for more documentation of this service: https://dev.projectoxford.ai/docs/services/56f91f2d778daf23d8ec6739/operations/56f91f2e778daf14a499e1fa
    
    func analyzeImage(image: UIImage, detectFeatures featureTypes: [FeatureTypes], completion:(AnyObject?, NSError?) -> Void) {
        
        // Note how calls to our completion block are wrapped in 'dispatch_async(dispatch_get_main_queue()) {}'.
        // This is necessary to ensure the completion block is called on the main queue. Only code on the main queue
        // may update user interface elements, call Cocoa APIs, etc.
        // It's also done to ensure the completion block is not called before this function returns, in case
        // the user of this function doesn't expect that to happen.
        
        // Check image properties to make sure it conforms to the API requirements.
        // Size must be > 50px by 50px
        guard image.size.height > 50 && image.size.width > 50 else {
            dispatch_async(dispatch_get_main_queue(), {
                let error = NSError(domain: "MSCSAPIClient", code: MSCSAPIClientError.ImageSizeError.rawValue, userInfo: [NSLocalizedDescriptionKey:"Image is too small."])
                completion(nil, error)
            })
            return
        }
        
        // Make sure we can create a valid JPEG version of the images.
        guard let imageData = UIImageJPEGRepresentation(image, 0.2) else {
            dispatch_async(dispatch_get_main_queue(), {
                let error = NSError(domain: "MSCSAPIClient", code: MSCSAPIClientError.ImageFormatError.rawValue, userInfo: [NSLocalizedDescriptionKey:"Image could not be converted to JPEG."])
                completion(nil, error)
            })
            return
        }
        
        // Image data size must be < 4MB total.
        guard imageData.length < 4 * 1024 * 1024 else {
            dispatch_async(dispatch_get_main_queue(), {
                let error = NSError(domain: "MSCSAPIClient", code: MSCSAPIClientError.ImageSizeError.rawValue, userInfo: [NSLocalizedDescriptionKey:"Image must be < 4 MB in size after being converted to JPEG."])
                completion(nil, error)
            })
            return
        }
        
        // Construct the URL for the request.
        let allFeatures = featureTypes.map { $0.rawValue }.joinWithSeparator(",")
        
        let parameters: [String] = ["visualFeatures=\(allFeatures)", "language=en"]
        let queryString = "?" + parameters.joinWithSeparator("&")
        let requestString = MSCSAPIClient.analyzeURL + queryString
        guard let requestURL = NSURL(string: requestString) else {
            dispatch_async(dispatch_get_main_queue(), {
                let error = NSError(domain: "MSCSAPIClient", code: MSCSAPIClientError.URLError.rawValue, userInfo: [NSLocalizedDescriptionKey:"There was a problem constructing the request URL."])
                completion(nil, error)
            })
            return
        }
        
        // Create the request and add the required HTTP fields and values.
        let request = NSMutableURLRequest(URL: requestURL)
        request.setValue(self.subscriptionKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        request.HTTPBody = imageData
        
        // Send the network data task.
        // Don't forget to call resume() on the new data task!
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            guard error == nil else {
                dispatch_async(dispatch_get_main_queue(), {
                    completion(nil, error)
                })
                return
            }
            
            // Make sure some data was returned.
            guard let responseData = data else {
                let error = NSError(domain: "MSCSAPIClient", code: MSCSAPIClientError.MissingData.rawValue, userInfo: [NSLocalizedDescriptionKey:"No data was returned."])
                dispatch_async(dispatch_get_main_queue(), {
                    completion(nil, error)
                })
                return
            }
            
            // Parse the raw text data into an object.
            guard let jsonObject = try? NSJSONSerialization.JSONObjectWithData(responseData, options: []) as? [String: AnyObject] else {
                let error = NSError(domain: "MSCSAPIClient", code: MSCSAPIClientError.JSONFormatError.rawValue, userInfo: [NSLocalizedDescriptionKey:"Coul not decode JSON data from response."])
                dispatch_async(dispatch_get_main_queue(), {
                    completion(nil, error)
                })
                return
            }
            
            // Return the JSON object if everything is ok.
            
            dispatch_async(dispatch_get_main_queue(), { 
                completion(jsonObject, error)
            })
            
            
        }.resume()
        
    }
 
}
