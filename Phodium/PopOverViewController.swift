//
//  PopOverViewController.swift
//  Phodium
//
//  Created by Viktor on 22/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Variables
    var sortingObjects:[String] = []
    var filteringObjects:[String] = []
    var filteredPosts = [CellContent]()
    var sortingState = false
    var menuVC = MenuVC()
    var popCell = PopCell()
    var allTags : [String] = []
    var filterTags = Singleton.sharedInstance.filterByTags

    var cellTapped: Bool = false
    var currentRow: Int = 0
    
    
    //MARK: Outlets
    @IBOutlet weak var sortingTableView: UITableView!
    @IBOutlet weak var filteringTableView: UITableView!

    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        sortingObjects = ["Name"]
        filteringObjects = ["PEOPLE", "WORLD", "SURVIVORS", "EU", "AFRICA", "EUROPE", "NATURE"]
        
        sortingTableView.delegate = self
        sortingTableView.dataSource = self
        filteringTableView.delegate = self
        filteringTableView.dataSource = self
        
        if Singleton.sharedInstance.filterOrder == true {
            popCell.sortingDirection?.text? = "Z-A"
        }else if Singleton.sharedInstance.filterOrder == false{
            popCell.sortingDirection?.text? = "A-Z"            
        }
        
        print(Singleton.sharedInstance.filterByTags)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.performSegueWithIdentifier("unwindSecondView", sender: self)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*func filterContent(tagText: String, scope: String = "All") {
     filteredCandies = candies.filter { candy in
     let categoryMatch = (scope == "All") || (candy.category == scope)
     return  categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
     }
     
     tableView.reloadData()
     }*/
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteringObjects = filteringObjects.filter { posts in
            return posts.lowercaseString.containsString(searchText.lowercaseString)
        }
        
    }
    
    //MARK: TableView Functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var cellCount: Int!
        
        if tableView == sortingTableView{
            cellCount = sortingObjects.count
        }
        else if tableView == filteringTableView{
            cellCount = filteringObjects.count
        }
        return cellCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if tableView == self.sortingTableView{
            let sCell = tableView.dequeueReusableCellWithIdentifier("sortingCell", forIndexPath: indexPath) as! PopCell
            cell = sCell
        let content = self.sortingObjects[indexPath.row]

        sCell.sortingText.text = content
            //sortingCell.sortingDirection.text = "From top"
        
        }
        else if tableView == self.filteringTableView{
            let fCell = tableView.dequeueReusableCellWithIdentifier("filteringCell", forIndexPath: indexPath) as! FilterCell
            cell = fCell
            let content = self.filteringObjects[indexPath.row]
            let row = indexPath.row
            let isSelected = Singleton.sharedInstance.filterOnOrOff[row]

            if Singleton.sharedInstance.filterByTags.contains(content){
                fCell.filterChoice.hidden = isSelected
            }else{
                fCell.filterChoice.hidden = !isSelected
            }

            fCell.filterText.text = content
            fCell.filterChoice.hidden = !isSelected

        }
        return cell
    }
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.sortingTableView{
            let sortingCell = tableView.cellForRowAtIndexPath(indexPath) as! PopCell
            
            sortingCell.sortingDirection.text = "A-Z"
            
            if Singleton.sharedInstance.filterOrder == true {
             sortingCell.sortingDirection.text = "Z-A"
                
                Singleton.sharedInstance.filterOrder = false
                //filteredPosts.sortInPlace({$0.name > $1.name})
                //NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                
                NSNotificationCenter.defaultCenter().postNotificationName("reload_data", object:self)

            }
            else if Singleton.sharedInstance.filterOrder == false {
             sortingCell.sortingDirection.text = "A-Z"
                Singleton.sharedInstance.filterOrder = true
                //filteredPosts.sortInPlace({$0.name < $1.name})
                //NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                
                NSNotificationCenter.defaultCenter().postNotificationName("reload_data", object:self)

             }

            tableView.reloadData()
            print(Singleton.sharedInstance.filterOrder)

        }
        else if tableView == self.filteringTableView{
            
            //filterOnOrOff
            //let filterCell = tableView.cellForRowAtIndexPath(indexPath) as! FilterCell
            
            let row = indexPath.row
            let tag = self.filteringObjects[indexPath.row]

            
            if Singleton.sharedInstance.filterOnOrOff[row] == false{
                Singleton.sharedInstance.filterOnOrOff[row] = true
                Singleton.sharedInstance.filterByTags.append(tag)
                print(Singleton.sharedInstance.filterByTags)
                
            }
            else if Singleton.sharedInstance.filterOnOrOff[row] == true{
                Singleton.sharedInstance.filterOnOrOff[row] = false
                let tagFilter = Singleton.sharedInstance.filterByTags.filter({$0 != tag})
                Singleton.sharedInstance.filterByTags = tagFilter
                print(Singleton.sharedInstance.filterByTags)
                
            }
            
            //filterCell.filterChoice.hidden = !filterCell.filterChoice.hidden
            
            
            //let selectedRowIndex = indexPath
            //currentRow = selectedRowIndex.row
            tableView.reloadData()
           
        }

    }
    
    //MARK: Actions
    
    @IBAction func closeButton(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindSecondView", sender: self)
    }
    
    
    
    
    
    

    
}
