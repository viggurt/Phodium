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
    
    var cell = CellContent?()
    var chosenObject = 0
    let VC: MenuVC? = nil
    var filtering: Filtering?
    
    @IBOutlet var menuTableView: UITableView!
    @IBAction func unwindSecondView(segue: UIStoryboardSegue){
        print("unwind triggrd")
        print(Singleton.sharedInstance.filterByTags)
        //Sorting Order
        if Singleton.sharedInstance.filterOrder == true {
            Singleton.sharedInstance.allCells.sortInPlace({$0.name < $1.name})
        }else if Singleton.sharedInstance.filterOrder == false{
            Singleton.sharedInstance.allCells.sortInPlace({$0.name > $1.name})
        }
        
        Singleton.sharedInstance.filteredCells.removeAll()
        
        //Filter Sorting
        Filtering.checkTheCell()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CellContent.downloadCells { (cells) in
            Singleton.sharedInstance.allCells = cells
            print(Singleton.sharedInstance.allCells)
            Filtering.sortByTags()
            self.tableView.reloadData()

        }
        

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int
        
        if Singleton.sharedInstance.filteredCells.isEmpty{
            count = Singleton.sharedInstance.allCells.count
        }
        else{
            count = Singleton.sharedInstance.filteredCells.count
        }
        return count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellMenu", forIndexPath: indexPath) as! MenuCell
        
        if Singleton.sharedInstance.filteredCells.isEmpty{
            let content = Singleton.sharedInstance.allCells[indexPath.row]
            cell.cellContent = content
        }
        else{
            let content = Singleton.sharedInstance.filteredCells[indexPath.row]
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
            
            if Singleton.sharedInstance.filteredCells.isEmpty{
                if let cell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPathForCell(cell){
                        VC?.chosenObject = Singleton.sharedInstance.allCells[indexPath.row]
                    }
                }
            }
            else{
                if let cell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPathForCell(cell){
                        VC?.chosenObject = Singleton.sharedInstance.filteredCells[indexPath.row]
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
                popOver.sourceRect = CGRect()
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
