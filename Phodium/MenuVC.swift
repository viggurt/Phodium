//
//  MenuVC.swift
//  Phodium
//
//  Created by Viktor on 02/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class MenuVC: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    var items = [CellContent]()
    var cell = CellContent?()
    var chosenObject = 0
    let VC: MenuVC? = nil
    var filteredCells = Singleton.sharedInstance.filteredCells
    
    @IBOutlet var menuTableView: UITableView!
    @IBAction func unwindSecondView(segue: UIStoryboardSegue){
        print("unwind triggrd")
        print(Singleton.sharedInstance.filterByTags)
        //Sorting Order
        if Singleton.sharedInstance.filterOrder == true {
            items.sortInPlace({$0.name < $1.name})
        }else if Singleton.sharedInstance.filterOrder == false{
            items.sortInPlace({$0.name > $1.name})
        }
        
        filteredCells.removeAll()
        
        //Filter Sorting
        for cells in items{
            let hashtags = cells.hashtags
            for tag in hashtags{
                
                if Singleton.sharedInstance.filterByTags.contains(tag) == cells.hashtags.contains(tag)
                {
                    
                    if filteredCells.contains ({return $0.name! as String == cells.name!}) {
                        filteredCells.filter({$0.name == cells.name!})
                    }
                    else{
                        filteredCells.append(cells)

                    }
                
                    
                }
              
            }
        }
        
        var i = 0
        for cells in filteredCells{
            
            
            
        }
    
    
    
        /*for cells in filteredCells{
            let hashtags = cells.hashtags
            for tag in hashtags{
                if Singleton.sharedInstance.filterByTags.contains(tag) == cells.hashtags.contains(tag)
                {
                    let cellFilter = filteredCells.filter({ !$0.hashtags.contains(tag)})
                    filteredCells = cellFilter
                    
                    print(filteredCells)
                    print("bababababa")
                    
                }
            }

        }*/
                    //Om "cells" i "filteredCells" inte har stringen "tag" i arrayen "hashtags" så ska "cells" tas bort ur "filteredCells"
                    
                    
/*for filterCell in filteredCells{
 let filterHashtags = filterCell.hashtags
 for filterTag in filterHashtags{
 
 }
 }*/
 
        tableView.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //allTags = Singleton.sharedInstance.filterByTags
        
        CellContent.downloadCells { (cells) in
            self.items = cells
            print(self.items)
            self.tableView.reloadData()
        }
        /*
        CellContent.downloadCells({ (cells) in
            self.items = cells
            print(self.items)

            self.tableView.reloadData()
        })
 */
        
      

    }
    
    func handleData() {
        self.menuTableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int
        
        if filteredCells.isEmpty{
            count = items.count
        }
        else{
            count = filteredCells.count
        }
        return count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellMenu", forIndexPath: indexPath) as! MenuCell
        
        /*for tags in self.items{
            let hashtags = tags.hashtags
                for tag in hashtags{
                        if Singleton.sharedInstance.filterByTags.contains(tag) == tags.hashtags.contains(tag)
                        {
         
                    }
                }
 
        }*/
        
        if filteredCells.isEmpty{
        let content = self.items[indexPath.row]
        
        cell.cellContent = content
        }
        else{
            let content = self.filteredCells[indexPath.row]
            
            cell.cellContent = content
        }
        
        return cell
    }
 
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenObject = indexPath.row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowObject" {
            
            let VC = segue.destinationViewController as? ViewController
            
            
            if filteredCells.isEmpty{
                if let cell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPathForCell(cell){
                        VC?.chosenObject = items[indexPath.row]
                    }
                }
            }
            else{
                if let cell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPathForCell(cell){
                        VC?.chosenObject = filteredCells[indexPath.row]
                    }
                }
            }
        }
        
            //Code from: https://www.youtube.com/watch?v=48UA06EwfrM and http://stackoverflow.com/questions/32666214/ios9-popover-always-points-to-top-left-corner-of-anchor
        else if segue.identifier == "showPopover" {
        
            let VC = segue.destinationViewController as? PopOverViewController
            
            VC!.modalPresentationStyle = UIModalPresentationStyle.Popover
            VC!.popoverPresentationController!.delegate = self
            if let popOver = VC!.popoverPresentationController{
                //let anchor = popOver.sourceView
                popOver.sourceRect = CGRect()
                //popOver.sourceRect = anchor!.bounds
                
           
            }
            
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    @IBAction func filterButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("showPopover", sender: self)

    }

    
}

