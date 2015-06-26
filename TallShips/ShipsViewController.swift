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
    
    let typePages = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
    
    let profilePages = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.typePages.dataSource = self
        let typePagesView = self.typePages.view
        typePagesView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(typePagesView!)
        
        self.profilePages.dataSource = self
        let profilePagesView = self.profilePages.view
        profilePagesView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(profilePagesView!)
        
        self.view.sendSubviewToBack(typePagesView)
        
        let views = Dictionary(dictionaryLiteral:
            ("profilePagesView", profilePagesView),
            ("typePagesView", typePagesView)
        )
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[profilePagesView]|", options: nil, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[typePagesView]|", options: nil, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[typePagesView(125)][profilePagesView]|", options: nil, metrics: nil, views: views))
        
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
                    self.profilePages.setViewControllers([shipController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: { (result) -> Void in
                        
                    })
                    
                    let typeController = self.storyboard?.instantiateViewControllerWithIdentifier("TypeViewController") as! TypeViewController
                    typeController.index = 0
                    typeController.ship = objects[0]
                    self.typePages.setViewControllers([typeController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: { (result) -> Void in
                        
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
        if (pageViewController == self.profilePages) {
            let controller = viewController as! ShipViewController
            if controller.index == 0 {
                return nil
            }
            return shipControllerAtIndex(controller.index-1)
        }
        else {
            let controller = viewController as! TypeViewController
            if controller.index == 0 {
                return nil
            }
            return shipControllerAtIndex(controller.index-1)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if (pageViewController == self.profilePages) {
            let controller = viewController as! ShipViewController
            if controller.index < self.items.count-1 {
                return shipControllerAtIndex(controller.index+1)
            }
        }
        else if (pageViewController == self.typePages) {
            let controller = viewController as! TypeViewController
            if controller.index < self.items.count-1 {
                return typeControllerAtIndex(controller.index+1)
            }
        }
        return nil
    }
    
    func typeControllerAtIndex(index: Int) -> TypeViewController {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("TypeViewController") as! TypeViewController
        controller.index = index
        controller.ship = self.items[index]
        return controller
    }
    
    func shipControllerAtIndex(index: Int) -> ShipViewController {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ShipViewController") as! ShipViewController
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
