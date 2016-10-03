//
//  CellContent.swift
//  Phodium
//
//  Created by Viktor on 01/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation

//Class from Youtube video: "https://www.youtube.com/watch?v=Lx-uvyXl87c , Duc Tran"
class CellContent {
    var name: String?
    var description: String?
    var hashtags: [String]
    var imageURL: NSURL?
    var url: NSURL?
     var tableView = MenuVC()
    
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
        
    }
    
    static func getTags(){
    }
    
    static func downloadCells(completion: (cells: [CellContent]) ->()) -> Void{
        
        let postEndPoint: String = "https://static.mobileinteraction.se/developertest/wordpressphotoawards.json"
        let url = NSURL(string: postEndPoint)!
        let session = NSURLSession.sharedSession()
        var cells = [CellContent]()
        
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
                    // Parse the JSON to get the IP
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if let files = jsonDictionary["files"] as? [[String: AnyObject]]{
                        for file in files {
                            let newFile = CellContent(file: file)
                            cells.append(newFile)
                        }
                        dispatch_async(dispatch_get_main_queue()){
                            completion(cells: cells)
                        }
                    }
            }catch {
                print("bad things happened")
            }
        }).resume()
    }
}
