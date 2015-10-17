//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Logan Yang on 10/15/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var memes: [Meme]{ return (UIApplication.sharedApplication().delegate as! AppDelegate).memes }
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set this in storyboard
//        myTableView.delegate = self
//        myTableView.dataSource = self
        
        // BUG: array is value typed, this is a copy of memes in AppDelegate and does not get updated
        // because it is in viewDidLoad(), only gets run once
//        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        memes = applicationDelegate.memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
    }
    
    
    // MARK: Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!
        let meme = self.memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        cell.imageView?.image = meme.memedImage!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}
