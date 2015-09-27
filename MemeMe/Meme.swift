//
//  Meme.swift
//  MemeMe
//
//  Created by Logan Yang on 8/19/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

class Meme{
    var topText: String!
    var bottomText: String!
    var imageOrigin: UIImage!
    var memedImage: UIImage!
    init(topTextField: UITextField, bottomTextField: UITextField, imageOrigin: UIImage, memedImage: UIImage) {
        self.topText = topTextField.text
        self.bottomText = bottomTextField.text
        self.imageOrigin = imageOrigin
        self.memedImage = memedImage
    }
}