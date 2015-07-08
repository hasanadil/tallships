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

class MapViewController: UIViewController, MKMapViewDelegate {
    
    let city = "pwm"
    @IBOutlet weak var map: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Key", style: UIBarButtonItemStyle.Plain, target: self, action: "tapKey:")
        
        let mapCenterCoordinate = CLLocationCoordinate2DMake(43.66057606, -70.24907112)
        self.map?.setRegion(MKCoordinateRegionMakeWithDistance(mapCenterCoordinate, 1600, 1600), animated: true)
        
        self.fetch()
    }
    
    func tapKey(sender: UIBarButtonItem) {
        let keyController = self.storyboard?.instantiateViewControllerWithIdentifier("MapKeyTableViewController") as! MapKeyTableViewController
        let nav = UINavigationController(rootViewController: keyController)
        nav.modalPresentationStyle = UIModalPresentationStyle.FormSheet
        self .presentViewController(nav, animated: true, completion: nil)
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
                        let color = object["color"] as? String
                        
                        let coordinate = CLLocationCoordinate2DMake(lat!.doubleValue, lng!.doubleValue)
                        
                        let annotation = PlaceAnnotation() as PlaceAnnotation
                        annotation.title = title
                        annotation.subtitle = subtitle
                        annotation.coordinate = coordinate
                        if let color = color {
                            annotation.color = color
                        }
                        self.map?.addAnnotation(annotation)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let place = annotation as! PlaceAnnotation
        let color = place.color
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.canShowCallout = true
        if color == "red" {
            pin.pinColor = MKPinAnnotationColor.Red
        }
        else if color == "green" {
            pin.pinColor = MKPinAnnotationColor.Green
        }
        else if color == "purple" {
            pin.pinColor = MKPinAnnotationColor.Purple
        }
        return pin
    }
}





