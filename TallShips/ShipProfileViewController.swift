//
//  ShipViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 6/14/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse

class ShipProfileViewController: ShipPageViewController {
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var aboutText: UILabel?
    @IBOutlet weak var typeLabel: UILabel?
    
    @IBOutlet weak var sponsorBackgroundView: UIView?
    @IBOutlet weak var sponsorImageView: UIImageView?
    
    @IBOutlet weak var flagImageView: UIImageView?
    @IBOutlet weak var shipImageView: UIImageView?
    @IBOutlet weak var shipImageViewActivityView: UIActivityIndicatorView?
    
    var height = 0 as CGFloat
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel?.text = self.ship["name"] as? String
        self.locationLabel?.text = self.ship["subtitle"] as? String
        self.aboutText?.text = self.ship["about"] as? String
        self.typeLabel?.text = self.ship["shipType"] as? String

        self.shipImageViewActivityView?.startAnimating()
        let imageFile = self.ship["image"] as? PFFile
        if let imageFile = imageFile {
            imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.shipImageView?.image = image
                    self.shipImageViewActivityView?.stopAnimating()
                }
            }
        }
        
        let sponsorImageFile = self.ship["sponsorImage"] as? PFFile
        if let sponsorImageFile = sponsorImageFile {
            sponsorImageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    
                    let imageRect = CGRectMake(0, 0, image!.size.width, image!.size.height) as CGRect
                    
                    println(imageRect)
                    if CGRectContainsRect(self.sponsorImageView!.bounds, imageRect) == true {
                        self.sponsorImageView?.contentMode = UIViewContentMode.Bottom
                    }
                    
                    self.sponsorImageView?.image = image
                }
            }
        }
        
        
        let sponsorColor = self.ship["sponsorColor"] as? String
        if let sponsorColor = sponsorColor {
            var color = UIColor(rgba: sponsorColor)
            self.sponsorBackgroundView?.backgroundColor = color
            self.view.backgroundColor = color
        }
        
        let sponsorAddress = self.ship["sponsorAddress"] as? String
        if let sponsorAddress = sponsorAddress {
            self.sponsorImageView?.userInteractionEnabled = true
            self.sponsorImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapSponsor:"))
        }
    }
    
    func tapSponsor(gesture: UIGestureRecognizer) {
        let sponsorAddress = self.ship["sponsorAddress"] as? String
        UIApplication.sharedApplication().openURL(NSURL(string: sponsorAddress!)!)
        
        let dimensions = [
            "address": sponsorAddress!,
        ]
        PFAnalytics.trackEventInBackground("sponsorTap", dimensions: dimensions, block: nil)
    }
}

