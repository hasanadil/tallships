//
//  MapKeyTableViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 7/7/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit

class MapKeyTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Map Key"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "tapClose:")
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func tapClose(sender: UIView) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.textColor = UIColor.whiteColor()

        if indexPath.row == 0 {
            cell.textLabel?.text = "Parking Locations"
            cell.backgroundColor = UIColor(red: 255.0/255.0, green: 56.0/255.0, blue: 36.0/255.0, alpha: 1.0)
        }
        else if indexPath.row == 1 {
            cell.textLabel?.text = "Food & Attractions"
            cell.backgroundColor = UIColor(red: 68.0/255.0, green: 219.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        }
        else if indexPath.row == 2 {
            cell.textLabel?.text = "Restrooms"
            cell.backgroundColor = UIColor(red: 201.0/255.0, green: 100.0/255.0, blue: 226.0/255.0, alpha: 1.0)
        }

        return cell
    }
}
