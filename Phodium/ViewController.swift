//
//  ViewController.swift
//  Phodium
//
//  Created by Viktor on 31/08/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var objectTitle: UILabel!
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var objectDescription: UILabel!
    @IBOutlet weak var objectTags: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var chosenObject: CellContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize.height = 1000
        
        objectTitle.text = chosenObject?.name
        objectDescription.text = chosenObject?.description
        
        let tags = chosenObject!.hashtags.prettyPrinted
        
        objectTags.text = tags
        
        let imageURL = chosenObject!.imageURL
        let networkService = NetworkService(url: imageURL!)
        networkService.downloadImage { (imageData) in
            let image = UIImage(data: imageData)
            dispatch_async(dispatch_get_main_queue(), {
                self.objectImage.image = image
            })
        }
        
    }
    
    

    //Code from: "http://stackoverflow.com/questions/36477168/why-is-my-image-not-showing-up-fullscreen"
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let newImageView = UIImageView(frame: CGRectMake(0, 0, screenSize.height * 1, screenSize.width * 1))
        newImageView.image = imageView.image
        //newImageView.frame = self.view.frame
        newImageView.backgroundColor = .whiteColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage" {
            
            let VC = segue.destinationViewController as? ImageViewController
            
            VC?.newImage = objectImage.image
            
        }
    }
}

//Code from "http://stackoverflow.com/questions/33345976/remove-characters-and-elements-from-array-of-strings-swift"
extension CollectionType where Generator.Element == String {
    var prettyPrinted: String {
        return self.joinWithSeparator(", ")
    }
}

