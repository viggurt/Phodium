//
//  MenuVC.swift
//  Phodium
//
//  Created by Viktor on 02/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class MenuVC: UITableViewController {
    
    var items: [CellContent] = []
    var chosenObject = 0
    let VC: MenuVC? = nil

    override func viewDidLoad() {
        downloadCells()
    }
    
    //Function got from a Youtube video "https://www.youtube.com/watch?v=uQ_MyVDiSbo"
    func downloadCells() -> Void{
        
        let postEndPoint: String = "https://static.mobileinteraction.se/developertest/wordpressphotoawards.json"
        let url = URL(string: postEndPoint)!
        
        
        let session = URLSession.shared
        // Make the POST call and handle it in a completion handler
        session.dataTask(with: url, completionHandler: { ( data: Data?, response: URLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? HTTPURLResponse ,
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                if let ipString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue) {
                    // Print what we got from the call
                    print(ipString)
                    
                    // Parse the JSON to get the IP
                    let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    let files = jsonDictionary["files"] as! [[String: AnyObject]]
                    
                    for file in files {
                        let newFile = CellContent(file: file)
                        self.items.append(newFile)
                    }
                    DispatchQueue.main.async{
                    self.tableView.reloadData()
                    }
                    
                }
            } catch {
                print("bad things happened")
            }
        } as! (Data?, URLResponse?, Error?) -> Void).resume()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellMenu", for: indexPath) as! MenuCell
        let content = self.items[(indexPath as NSIndexPath).row]

        cell.cellContent = content        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenObject = (indexPath as NSIndexPath).row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowObject" {
            
            let VC = segue.destination as? ViewController
            
            if let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPath(for: cell){
                    VC?.chosenObject = items[(indexPath as NSIndexPath).row]
                }
            }
        
        }
    }
    
    //
    @IBAction func sortBy(_ sender: AnyObject) {
        items.sort(by: {$0.name < $1.name})
        self.tableView.reloadData()
    }
    
}

