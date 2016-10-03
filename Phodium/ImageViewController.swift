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

    @IBAction func toggle(sender: AnyObject) {
    navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
    return navigationController?.navigationBarHidden == true
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
    return UIStatusBarAnimation.Slide
    }
}
