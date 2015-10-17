//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Logan Yang on 10/15/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

// why no delegate and dataSource??
// first time into collection view, image size very small, then recover
class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]{ return (UIApplication.sharedApplication().delegate as! AppDelegate).memes }
    
    @IBOutlet var myCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 1.0
        let xDimension = (view.frame.size.width - 2 * space) / 3.0
        let yDimension = (view.frame.size.height - 2 * space) / 4.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(xDimension, yDimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        myCollectionView.reloadData()
    }
    
    
    // MARK: Collection View Data Source
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        // Set image
        cell.memeImageView?.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        detailController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailController, animated: true)
        
    }

}