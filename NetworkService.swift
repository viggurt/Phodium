//
//  NetworkService.swift
//  Phodium
//
//  Created by Viktor on 01/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation

//Class from Youtube video: "https://www.youtube.com/watch?v=Lx-uvyXl87c , Duc Tran"
class NetworkService
{
    lazy var configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.configuration)
    
    let url: NSURL
    
    init(url: NSURL) {
        self.url = url
    }
    
    typealias ImageDataHandler = (NSData -> Void)
    
    func downloadImage(completion: ImageDataHandler)
    {
        let request = NSURLRequest(URL: self.url)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            if error == nil {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch (httpResponse.statusCode) {
                    case 200:
                        if let data = data {
                            completion(data)
                        }
                    default:
                        print(httpResponse.statusCode)
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        dataTask.resume()
    }
    
    //Function got from a Youtube video "https://www.youtube.com/watch?v=uQ_MyVDiSbo"
/*func downloadCells() -> [CellContent]{
 
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
 }
 
 catch {
 print("bad things happened")
 }
 }).resume()
 return cells
 }*/
}

extension NetworkService
{
    static func parseJSONFromData(jsonData: NSData?) -> [String : AnyObject]?
    {
        if let data = jsonData {
            do {
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject]
                return jsonDictionary
 
            } catch let error as NSError {
                print("error processing json data: \(error.localizedDescription)")
            }
        }
 
        return nil
    }
}


