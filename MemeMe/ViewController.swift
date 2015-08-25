//
//  ViewController.swift
//  MemeMe
//
//  Created by Logan Yang on 8/19/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var bottomToolBar: UIToolbar!

    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
        // negative to fill inside the char
        NSStrokeWidthAttributeName : -4.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup top textfield
        self.topTextField.text = "TOP"
        self.topTextField.defaultTextAttributes = memeTextAttributes
        // add textAlignment after defaultTextAttributes to avoid overriding
        // transparent background
        self.topTextField.backgroundColor = UIColor.clearColor()
        self.topTextField.textAlignment = NSTextAlignment.Center
        self.topTextField.delegate = self
        // setup bottom textfield
        self.bottomTextField.text = "BOTTOM"
        self.bottomTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.backgroundColor = UIColor.clearColor()
        self.bottomTextField.textAlignment = NSTextAlignment.Center
        self.bottomTextField.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardHideNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        self.unsubscribeFromKeyboardHideNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Picking an image from album
    @IBAction func pickAnImage(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func share(sender: AnyObject) {
        // generate the memedImage
        var memedImage = generateMemedImage()
        // define an instance of the ActivityViewController
        let controller = UIActivityViewController(activityItems: [memedImage],
            applicationActivities: nil)
        // save the meme object after sharing
        // this is called a Closure
        controller.completionWithItemsHandler = {(save, completed, items, error) in
            if completed {
                self.save(memedImage)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    
    // Image Picker Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicker.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // TextField Delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    // keyboard subscription for keyboardWillShow
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }
    
    // keyboard subscription for keyboardWillHide
    func subscribeToKeyboardHideNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardHideNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    // when the keyboardWillShow notification is received, shift the view's frame up
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            //self.view.frame.origin.y -= getKeyboardHeight(notification)
            self.view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // when the keyboardWillHide notification is received, shift the view's frame down
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            //self.view.frame.origin.y += getKeyboardHeight(notification)
            self.view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // saving the Meme
    func save(memedImage: UIImage) {
        //Create the meme object
        var meme = Meme(topTextField: topTextField, bottomTextField: bottomTextField,
            imageOrigin: imagePicker.image!, memedImage: memedImage)
    }
    
    // generate MemedImage
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        bottomToolBar.hidden = true

        // Render view to an image
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, 2.0)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        bottomToolBar.hidden = false
        
        return memedImage
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

