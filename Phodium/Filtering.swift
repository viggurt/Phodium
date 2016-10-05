//
//  Filtering.swift
//  Phodium
//
//  Created by Viktor on 03/10/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation

class Filtering {
    
    static func checkTheCell(){
        for cell in Singleton.sharedInstance.allCells{
            let hashtags = cell.hashtags
            for tag in hashtags{
                if Singleton.sharedInstance.filterByTags.contains(tag) == cell.hashtags.contains(tag)
                {
                    if !Singleton.sharedInstance.filteredCells.contains(cell) {
                        Singleton.sharedInstance.filteredCells.append(cell)
                    }
                }
            }
        }
    }//checkIfCellAlreadyExist ended
    
    static func sortByTags(){
        for cell in Singleton.sharedInstance.allCells{
            let hashtags = cell.hashtags
            for tag in hashtags{
                if !Singleton.sharedInstance.filteringObjects.contains(tag){
                    Singleton.sharedInstance.filteringObjects.append(tag)
                }
            }
        }
    }
   
}
