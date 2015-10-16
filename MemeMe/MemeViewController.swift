//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Logan Yang on 10/15/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeViewController: UIViewController {
    var meme: Meme!
    @IBOutlet weak var memedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = true
        
        self.memedImage!.image = meme.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }

}


