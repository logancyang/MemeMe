//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Logan Yang on 10/15/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

//import UIKit
//
//class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//
//    var memes: [Meme]!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        memes = applicationDelegate.memes
//    }
//    
//    // MARK: Table View Data Source
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return memes.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("VillainCell")!
//        let villain = self.allVillains[indexPath.row]
//        
//        // Set the name and image
//        cell.textLabel?.text = villain.name
//        cell.imageView?.image = UIImage(named: villain.imageName)
//        
//        // If the cell has a detail label, we will put the evil scheme in.
//        if let detailTextLabel = cell.detailTextLabel {
//            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
//        }
//        
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("VillainDetailViewController") as! VillainDetailViewController
//        detailController.villain = self.allVillains[indexPath.row]
//        self.navigationController!.pushViewController(detailController, animated: true)
//        
//    }
//    
//}
