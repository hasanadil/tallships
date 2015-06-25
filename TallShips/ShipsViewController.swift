//
//  ShipsViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 6/14/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse

class ShipsViewController: UIViewController, UIPageViewControllerDataSource {
    
    let city = "pwm"
    var items = [] as [PFObject]
    
    @IBOutlet weak var shipsScrollView: UIScrollView?
    let pages = UIPageViewController() as UIPageViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.pages.dataSource = self
        let pagesView = self.pages.view
        pagesView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view.addSubview(pagesView!)
        let views = Dictionary(dictionaryLiteral: ("pagesView", pagesView), ("shipsScrollView", self.shipsScrollView))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[pagesView]|", options: nil, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[shipsScrollView][pagesView]|", options: nil, metrics: nil, views: views))
        
        self.loadShips()
    }
    
    func tapTickets(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.eventbrite.com/e/iberdrola-usa-tall-ships-portland-2015-tickets-tickets-16342218014?ref=ebtn")!)
    }
    
    func loadShips() {
        var query = PFQuery(className:"Ship")
        query.whereKey("city", equalTo:self.city)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                    }
                    
                    self.items = objects
                    
                    let shipController = self.storyboard?.instantiateViewControllerWithIdentifier("ShipViewController") as! ShipViewController
                    shipController.index = 0
                    shipController.ship = objects[0]
                    self.pages.setViewControllers([shipController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: { (result) -> Void in
                        
                        self.view.bringSubviewToFront(self.shipsScrollView!)
                    })
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }

    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let shipController = viewController as! ShipViewController
        if shipController.index == 0 {
            return nil
        }
        return controllerAtIndex(shipController.index-1)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let shipController = viewController as! ShipViewController
        if shipController.index < self.items.count-1 {
            return controllerAtIndex(shipController.index+1)
        }
        return nil
    }
    
    func controllerAtIndex(index: Int) -> ShipViewController {
        let shipController = self.storyboard?.instantiateViewControllerWithIdentifier("ShipViewController") as! ShipViewController
        shipController.index = index
        shipController.ship = self.items[index]
        return shipController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.items.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
