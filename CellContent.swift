//
//  CellContent.swift
//  Phodium
//
//  Created by Viktor on 01/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation

class CellContent {
    var name: String?
    var description: String?
    var hashtags: [String]
    var imageURL: NSURL?
    var url: NSURL?
    
    init(name: String, description: String, hashtags: [String], imageURL: NSURL){
        self.name = name
        self.description = description
        self.hashtags = hashtags
        self.imageURL = imageURL
    }
    
    init(file: [String : AnyObject]){
        self.name = file["name"] as? String
        description = file["description"] as? String
        hashtags = file["tags"] as! [String]
        imageURL = NSURL(string: file["url"] as! String)
        print(name)
        
    }
    
    static func downloadCells() -> [CellContent]{
        
        var cells = [CellContent]()
        
        /*let jsonFile = NSBundle.mainBundle().pathForResource("PhotoAwards", ofType: "json")
        let jsonData = NSData(contentsOfFile: jsonFile!)
        
        //turn the data into foundation object
        if let jsonDictionary = NetworkService.parseJSONFromData(jsonData) {
            let files = jsonDictionary["files"] as! [[String: AnyObject]]
            
            for file in files {
                let newFile = CellContent(file: file)
                cells.append(newFile)
            }
            
        }
        */
        
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
                        cells.append(newFile)
                    }
                    
                    
                }
            } catch {
                print("bad things happened")
            }
        }).resume()
        
        return cells
    }
}
