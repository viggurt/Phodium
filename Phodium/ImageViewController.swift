//
//  ImageViewController.swift
//  Phodium
//
//  Created by Viktor on 22/09/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var newImage: UIImage!
    
    var chosenObject: CellContent?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = newImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 

}
