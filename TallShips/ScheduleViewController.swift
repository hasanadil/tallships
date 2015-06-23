//
//  ScheduleViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 6/14/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse

class ScheduleViewController: UITableViewController {
    
    let city = "pwm"
    var items = [] as [PFObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tickets", style: UIBarButtonItemStyle.Plain, target: self, action: "tapTickets:")
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let newsNib = UINib(nibName: "ScheduleTableViewCell", bundle: nil) as UINib
        self.tableView .registerNib(newsNib, forCellReuseIdentifier: "ScheduleTableViewCell")
        self.fetch()
    }
    
    func tapTickets(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.eventbrite.com/e/iberdrola-usa-tall-ships-portland-2015-tickets-tickets-16342218014?ref=ebtn")!)
    }
    
    func fetch() {
        var query = PFQuery(className:"Schedule")
        query.whereKey("city", equalTo:self.city)
        query.orderByAscending("startDttm")
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
        return self.items.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let scheduleItem = self.items[section] as PFObject
        let allDay = scheduleItem["allDay"] as? Bool
        let startDttm = scheduleItem["startDttm"] as? NSDate
        
        let formatter = NSDateFormatter() as NSDateFormatter
        formatter.dateStyle = NSDateFormatterStyle.FullStyle
        if allDay! == true {
            return formatter.stringFromDate(startDttm!)
        }
        else {
            formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            return formatter.stringFromDate(startDttm!)
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = self.items[indexPath.section] as PFObject
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleTableViewCell", forIndexPath: indexPath) as! ScheduleTableViewCell
        cell.setSchedule(item)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item = self.items[indexPath.section] as PFObject
        
        let textController = self.storyboard?.instantiateViewControllerWithIdentifier("TextViewController") as!TextViewController
        textController.textTitle = item["title"] as! String
        textController.text = item["detail"] as! String
        self.navigationController?.pushViewController(textController, animated: true)
    }
}






