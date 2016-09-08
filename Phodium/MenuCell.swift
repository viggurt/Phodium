//
//  MenuCell.swift
//  Phodium
//
//  Created by Viktor on 02/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    
    var cellContent: CellContent! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        
        title.text = cellContent.name
        
        let imageURL = cellContent.imageURL
        let networkService = NetworkService(url: imageURL!)
        networkService.downloadImage { (imageData) in
            let image = UIImage(data: imageData)
            dispatch_async(dispatch_get_main_queue(), {
                self.menuImage.image = image
            })
        }
        
        
    }
    
}