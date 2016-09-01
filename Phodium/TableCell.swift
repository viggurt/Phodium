//
//  TableCell.swift
//  Phodium
//
//  Created by Viktor on 31/08/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    
    var cellContent: CellContent! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
       
        nameLabel.text = cellContent.name
        descriptionLabel.text = cellContent.description
        tagLabel.text = "\(cellContent.hashtags)"
        
        let imageURL = cellContent.imageURL
        let networkService = NetworkService(url: imageURL!)
        networkService.downloadImage { (imageData) in
            let image = UIImage(data: imageData)
            dispatch_async(dispatch_get_main_queue(), {
                self.cellImage.image = image
            })
        }
        
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
}
