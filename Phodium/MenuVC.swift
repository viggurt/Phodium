//
//  MenuVC.swift
//  Phodium
//
//  Created by Viktor on 02/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class MenuVC: UITableViewController {
    
    var items: [CellContent] = []
    var chosenObject = 0
    let VC: MenuVC? = nil

    override func viewDidLoad() {
        downloadCells()
    }
    
    func downloadCells() -> Void{
        
        let postEndPoint: String = "https://static.mobileinteraction.se/developertest/wordpressphotoawards.json"
        let url = NSURL(string: postEndPoint)!
        
        
        let session = NSURLSession.sharedSession()
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                if let ipString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    // Print what we got from the call
                    print(ipString)
                    
                    // Parse the JSON to get the IP
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    let files = jsonDictionary["files"] as! [[String: AnyObject]]
                    
                    for file in files {
                        let newFile = CellContent(file: file)
                        self.items.append(newFile)
                    }
                    dispatch_async(dispatch_get_main_queue()){
                    self.tableView.reloadData()
                    }
                    
                }
            } catch {
                print("bad things happened")
            }
        }).resume()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellMenu", forIndexPath: indexPath) as! MenuCell
        let content = self.items[indexPath.row]

        cell.cellContent = content        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenObject = indexPath.row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowObject" {
            
            let VC = segue.destinationViewController as? ViewController
            
            if let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPathForCell(cell){
                    VC?.chosenObject = items[indexPath.row]
                }
            }
        
        }
    }
    
    @IBAction func sortBy(sender: AnyObject) {
        items.sortInPlace({$0.name < $1.name})
        self.tableView.reloadData()
    }
    
}

