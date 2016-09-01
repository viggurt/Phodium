//
//  TableViewVC.swift
//  Phodium
//
//  Created by Viktor on 31/08/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class TableViewVC: UITableViewController {
    
    var names: [String] = []
    
    var cellContents = [CellContent]()

    
    override func viewDidLoad() {
        names = ["Firasdljasdjlnadjnlasdljnst"]
        
        cellContents = CellContent.downloadCells()
        self.tableView.reloadData()

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? TableCell
        let content = self.cellContents[indexPath.row]
        
        cell?.cellContent = content

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}