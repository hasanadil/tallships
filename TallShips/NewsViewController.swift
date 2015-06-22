//
//  NewsViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 6/16/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse

class NewsViewController: UITableViewController {
    
    let city = "pwm"
    var allNews = [] as [PFObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let newsNib = UINib(nibName: "NewsTableViewCell", bundle: nil) as UINib
        self.tableView .registerNib(newsNib, forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        self.loadNews()
    }
    
    func loadNews() {
        var query = PFQuery(className:"News")
        query.whereKey("city", equalTo:self.city)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                    }
                    
                    self.allNews = objects
                    self.tableView.reloadData()
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allNews.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsTableViewCell", forIndexPath: indexPath) as! NewsTableViewCell
        let news = allNews[indexPath.row] as PFObject
        cell.setNews(news)
        return cell
    }
}
