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
    
    let profilePages = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.profilePages.dataSource = self
        let profilePagesView = self.profilePages.view
        profilePagesView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(profilePagesView!)
        
        let views = Dictionary(dictionaryLiteral:
            ("profilePagesView", profilePagesView)
        )
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[profilePagesView]|", options: nil, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[profilePagesView]|", options: nil, metrics: nil, views: views))
        
        self.fetch()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func tapTickets(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.eventbrite.com/e/iberdrola-usa-tall-ships-portland-2015-tickets-tickets-16342218014?ref=ebtn")!)
    }
    
    func fetch() {
        var query = PFQuery(className:"Ship")
        query.orderByAscending("order")
        query.whereKey("city", equalTo:self.city)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                    }
                    
                    self.items = objects
                    
                    let shipController = self.storyboard?.instantiateViewControllerWithIdentifier("ShipProfileViewController") as! ShipProfileViewController
                    shipController.index = 0
                    shipController.ship = objects[0]
                    self.profilePages.setViewControllers([shipController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: { (result) -> Void in
                        
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
        
        let shipPage = viewController as! ShipPageViewController
        let newIndex = shipPage.index - 1
        
        if (pageViewController == self.profilePages) {
            if shipPage.index == 0 {
                return nil
            }
            
            return shipControllerAtIndex(newIndex)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let shipPage = viewController as! ShipPageViewController
        let newIndex = shipPage.index + 1
        
        if (pageViewController == self.profilePages) {
            if shipPage.index < self.items.count-1 {
                return shipControllerAtIndex(newIndex)
            }
        }
        return nil
    }
    
    func shipControllerAtIndex(index: Int) -> ShipProfileViewController {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ShipProfileViewController") as! ShipProfileViewController
        controller.index = index
        controller.ship = self.items[index]
        return controller
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.items.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
