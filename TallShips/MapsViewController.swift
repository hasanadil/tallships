//
//  MapsViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 6/30/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import MapKit
import Parse

class MapsViewController: UIViewController {
    
    let city = "pwm"
    @IBOutlet weak var map: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "tapFilter:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tickets", style: UIBarButtonItemStyle.Plain, target: self, action: "tapTickets:")
        
        let mapCenterCoordinate = CLLocationCoordinate2DMake(43.66057606, -70.24907112)
        self.map?.setRegion(MKCoordinateRegionMakeWithDistance(mapCenterCoordinate, 1600, 1600), animated: true)
        
        self.fetch()
    }
    
    func tapFilter(sender: UIBarButtonItem) {
        
    }
    
    func tapTickets(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.eventbrite.com/e/iberdrola-usa-tall-ships-portland-2015-tickets-tickets-16342218014?ref=ebtn")!)
    }
    
    func fetch() {
        var query = PFQuery(className:"Map")
        query.whereKey("city", equalTo:self.city)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        let title = object["title"] as? String
                        println(title)
                        let subtitle = object["subtitle"] as? String
                        let lat = object["lat"] as? NSNumber
                        let lng = object["lng"] as? NSNumber
                        
                        let coordinate = CLLocationCoordinate2DMake(lat!.doubleValue, lng!.doubleValue)
                        
                        let annotation = MKPointAnnotation() as MKPointAnnotation
                        annotation.title = title
                        annotation.subtitle = subtitle
                        annotation.coordinate = coordinate
                        self.map?.addAnnotation(annotation)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
}





