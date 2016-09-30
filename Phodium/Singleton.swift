//
//  Singleton.swift
//  Phodium
//
//  Created by Viktor on 26/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation

class Singleton {
    static let sharedInstance = Singleton()
    
    var filterOrder = false
    
    var filterByTags: [String] = []
    
    var filterOnOrOff = [false, false, false, false, false, false, false]
    
    var filteredCells = [CellContent]()
}
