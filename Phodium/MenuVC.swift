//
//  MenuVC.swift
//  Phodium
//
//  Created by Viktor on 02/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class MenuVC: UITableViewController {
    
    var items: [CellContent] = []
    var chosenObject = 0
    
    override func viewDidLoad() {
        items = CellContent.downloadCells()
        self.tableView.reloadData()
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellMenu", forIndexPath: indexPath) as! MenuCell
        let content = self.items[indexPath.row]

        cell.cellContent = content
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenObject = indexPath.row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowObject" {
            
            let VC = segue.destinationViewController as? ViewController
            
            if let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPathForCell(cell){
                    VC?.chosenObject = items[indexPath.row]
                }
            }
        
        }
    }
}