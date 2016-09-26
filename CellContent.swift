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
    var imageURL: URL?
    var url: URL?
    
    init(name: String, description: String, hashtags: [String], imageURL: URL){
        self.name = name
        self.description = description
        self.hashtags = hashtags
        self.imageURL = imageURL
    }
    
    
    
    init(file: [String : AnyObject]){
        self.name = file["name"] as? String
        description = file["description"] as? String
        hashtags = file["tags"] as! [String]
        imageURL = URL(string: file["url"] as! String)
        
    }
    
}
