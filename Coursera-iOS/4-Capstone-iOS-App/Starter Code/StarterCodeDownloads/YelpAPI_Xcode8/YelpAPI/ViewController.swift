
import UIKit

// This view controller sends a search request to find 'pizza' near 'university of toronto'.
// The results are displayed in a table view as a list of business names and phone numbers.

class ViewController: UITableViewController {

    static let ClientId = "Enter your Yelp Client ID here."
    static let ClientSecret = "Enter your Yelp Client Secret here."

    
    var yelpClient: YelpAPIClient!
    
    var businessList = [AnyObject]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        YelpAPIClient.connectClient(ViewController.ClientId, secret: ViewController.ClientSecret) { (client, error) in
            guard error == nil else {
                let alert = UIAlertController(title: "Connection Error", message: error?.localizedDescription ?? "Yelp connection error.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction.init(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                return
            }
            self.yelpClient = client
            client?.locationSearch("pizza", location: "university of toronto", completion: { (data, error) in
                guard error == nil else {
                    let alert = UIAlertController(title: "Connection Error", message: error?.localizedDescription ?? "Yelp connection error.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction.init(title: "OK", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }
                guard let unwrappedData = data as? Dictionary<String, AnyObject> else {
                    let alert = UIAlertController(title: "Connection Error", message: error?.localizedDescription ?? "Yelp data format error", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction.init(title: "OK", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }
                guard let businessList = unwrappedData["businesses"] as? Array<AnyObject> else {
                    let alert = UIAlertController(title: "Connection Error", message: error?.localizedDescription ?? "Yelp data format error", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction.init(title: "OK", style: .Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }
                self.businessList = businessList
            })
            
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        if let business = businessList[indexPath.row] as? Dictionary<String, AnyObject> {
            let name = (business["name"] as? String) ?? "*No name.*"
            let phoneNumber = (business["phone"] as? String) ?? "*No phone #.*"
            cell.textLabel!.text = "\(name): \(phoneNumber)"
        } else {
            cell.textLabel!.text = "*No name.*"
        }
        return cell
        
    }


}

