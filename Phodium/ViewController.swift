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
            let image = UIImage(data: imageData as Data)
            DispatchQueue.main.async(execute: {
                self.objectImage.image = image
            })
        }
    
    }//End of viewDidLoad

    //Code from: "http://stackoverflow.com/questions/36477168/why-is-my-image-not-showing-up-fullscreen"
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = self.view.frame
        //newImageView.backgroundColor = .backgroundColor
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
}//End of class

//Code from "http://stackoverflow.com/questions/33345976/remove-characters-and-elements-from-array-of-strings-swift"
extension Collection where Iterator.Element == String {
    var prettyPrinted: String {
        return self.joined(separator: ", ")
    }
}

