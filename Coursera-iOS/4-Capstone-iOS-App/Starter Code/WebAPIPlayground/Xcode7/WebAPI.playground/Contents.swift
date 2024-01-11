
// Use this playground to experiment with Web APIs.
// It is configured to use Microsoft's Computer Vision API, however, you can reconfigure it to use other web APIs.
// Make sure to add your own subscription key to the configuration section, below.


import UIKit

import XCPlayground

// This keeps the playground active while it is waiting for a result from the server.
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


// Configuration
let subscriptionKey = ""
let apiLocation = "https://westus.api.cognitive.microsoft.com/vision/v1.0/analyze"
let image = UIImage(named: "sample.png")!
let imageData = UIImageJPEGRepresentation(image, 0.2)!

let httpQuery = [
    "visualFeatures": "Categories,Tags,Description,Faces,ImageType,Color,Adult",
    "language": "en"
]

let httpHeaderFields = [
    "Content-Type": "application/octet-stream",
    "Ocp-Apim-Subscription-Key": subscriptionKey
]

let httpMethod = "POST"
let httpBody: NSData? = imageData

// Use this String extension method to encode a string to be passed in a URL request.
// When sending a string as a parameter in a URL query, you must replace certain characters with escape sequences.
// This function will return a string that is safe to embed in a URL query.
// It will escape any non-alphanumeric characters, except for the specified exceptions.

extension String {
    func encodedStringForURLEncodedFormData() -> String? {
        let exceptions = "*-._,"
        let allowed = NSMutableCharacterSet.alphanumericCharacterSet()
        allowed.addCharactersInString(exceptions)
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowed)
    }
}


// Construct URL for the request by appending the httpQuery to the apiLocation

let queryElements = httpQuery.map { (key: String, value: String) -> String in
    return "\(key)=\(value.encodedStringForURLEncodedFormData() ?? "")"
}
let queryString = "?" + queryElements.joinWithSeparator("&")
let requestURL = NSURL(string: apiLocation + queryString)!


// Create the request. This is where we combine the request URL, HTTP Fields, and HTTP body data.

let request = NSMutableURLRequest(URL: requestURL)
for (fieldName, fieldValue) in httpHeaderFields {
    request.setValue(fieldValue, forHTTPHeaderField: fieldName)
}
request.HTTPMethod = httpMethod
if let bodyData = httpBody {
    request.HTTPBody = httpBody
}


// Connect to the server and make the request.
NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) in
    XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
    
    guard error == nil else {
        print(error!.localizedDescription)
        return
    }
    
    guard let responseInfo = response as? NSHTTPURLResponse else {
        print("No HTTP response given")
        return
    }
    
    print("Response Code: \(responseInfo.statusCode)")
    guard let responseData = data else {
        print("No data returned.")
        return
    }
    
    guard let jsonObject = try? NSJSONSerialization.JSONObjectWithData(responseData, options: []) as? [String: AnyObject] else {
        print("The data returned by the API is not in JSON format.")
        return
    }
    
    print(jsonObject ?? "JSON object contains no data.")
    
}).resume()

