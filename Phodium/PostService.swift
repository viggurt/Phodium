//
//  PostService.swift
//  Phodium
//
//  Created by Viktor on 05/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation

class PostService{
    var cells: [CellContent]!
    
    func getPost(){
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
                        self.cells.append(newFile)
                    }
                    
                    
                }
            } catch {
                print("bad things happened")
            }
        }).resume()
        
    }
    
    
}