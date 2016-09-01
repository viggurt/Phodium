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
    var hashtags: [String]?
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
        hashtags = file["tags"] as? [String]
        imageURL = NSURL(string: file["url"] as! String)
        
    }
    
    static func downloadCells() -> [CellContent]{
        
        var cells = [CellContent]()
        
        let jsonFile = NSBundle.mainBundle().pathForResource("PhotoAwards", ofType: "json")
        let jsonData = NSData(contentsOfFile: jsonFile!)
        
        //turn the data into foundation object
        if let jsonDictionary = NetworkService.parseJSONFromData(jsonData) {
            let files = jsonDictionary["files"] as! [[String: AnyObject]]
            
            for file in files {
                let newFile = CellContent(file: file)
                cells.append(newFile)
            }
        }
        
        return cells
    }
}
