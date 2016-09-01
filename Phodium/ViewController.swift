//
//  ViewController.swift
//  Phodium
//
//  Created by Viktor on 31/08/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var url: String = "https://static.mobileinteraction.se/developertest/wordpressphotoawards.json"
    
    var names: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        names = ["Kalle", "Viktor", "Matte", "balle"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


}

