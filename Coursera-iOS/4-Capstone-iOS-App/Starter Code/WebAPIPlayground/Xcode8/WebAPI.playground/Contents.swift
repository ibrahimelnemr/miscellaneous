// Use this playground to experiment with Web APIs.
// It is configured to use Microsoft's Computer Vision API, however, you can reconfigure it to use other web APIs.
// Make sure to add your own subscription key to the configuration section, below.
// Note: This example uses Swift 3, which is required for playgrounds in Xcode 8. (The example app uses Swift 2.x.)

import UIKit
import PlaygroundSupport

// This keeps the playground active while it is waiting for a result from the server.
PlaygroundPage.current.needsIndefiniteExecution = true


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
let httpBody: Data? = imageData

// Use this String extension method to encode a string to be passed in a URL request.
// When sending a string as a parameter in a URL query, you must replace certain characters with escape sequences.
// This function will return a string that is safe to embed in a URL query.
// It will escape any non-alphanumeric characters, except for the specified exceptions.

extension String {
    func encodedStringForURLEncodedFormData() -> String? {
        let exceptions = "*-._,"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: exceptions)
        
        return self.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}


// Construct URL for the request by appending the httpQuery to the apiLocation

let queryElements = httpQuery.map { (key: String, value: String) -> String in
    return "\(key)=\(value.encodedStringForURLEncodedFormData() ?? "")"
}
let queryString = "?" + queryElements.joined(separator: "&")
let requestURL = URL(string: apiLocation + queryString)!


// Create the request. This is where we combine the request URL, HTTP Fields, and HTTP body data.

let request = NSMutableURLRequest(url: requestURL)
for (fieldName, fieldValue) in httpHeaderFields {
    request.setValue(fieldValue, forHTTPHeaderField: fieldName)
}
request.httpMethod = httpMethod
if let bodyData = httpBody {
    request.httpBody = bodyData
}


// Connect to the server and make the request.
URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
    PlaygroundPage.current.needsIndefiniteExecution = false
    
    guard error == nil else {
        print(error!.localizedDescription)
        return
    }
    
    guard let responseInfo = response as? HTTPURLResponse else {
        print("No HTTP response given")
        return
    }
    
    print("Response Code: \(responseInfo.statusCode)")
    guard let responseData = data else {
        print("No data returned.")
        return
    }
    
    guard let jsonObject = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
        print("The data returned by the API is not in JSON format.")
        return
    }
    
    print(jsonObject ?? "JSON object contains no data.")
    
}).resume()


