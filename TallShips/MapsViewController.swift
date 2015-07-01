//
//  MapsViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 7/1/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse

class MapsViewController: UITableViewController {
    
    let city = "pwm"
    var items = [] as [PFObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tickets", style: UIBarButtonItemStyle.Plain, target: self, action: "tapTickets:")
        
        self.fetch()
    }
    
    func tapTickets(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.eventbrite.com/e/iberdrola-usa-tall-ships-portland-2015-tickets-tickets-16342218014?ref=ebtn")!)
    }
    
    func fetch() {
        var query = PFQuery(className:"MapFiles")
        query.whereKey("city", equalTo:self.city)
        query.orderByAscending("order")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                    }
                    
                    self.items = objects
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return self.items.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        if indexPath.section == 0 {
            cell.textLabel?.text = "Live Map"
        }
        else if indexPath.section == 1 {
            let object = self.items[indexPath.row] as PFObject
            let title = object["title"] as? String
            cell.textLabel?.text = title
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 {
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as! UIViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if indexPath.section == 1 {
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("PDFViewController") as! PDFViewController
            controller.object = self.items[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
