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
        }
        
        let sponsorAddress = self.ship["sponsorAddress"] as? String
        if let sponsorAddress = sponsorAddress {
            self.sponsorImageView?.userInteractionEnabled = true
            self.sponsorImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapSponsor:"))
        }
        
        /*
        let name = NSAttributedString(
            string: self.ship["name"] as! String,
            attributes: [NSFontAttributeName : UIFont.systemFontOfSize(42)]
        )
        let subtitle = NSAttributedString(
            string: self.ship["subtitle"] as! String,
            attributes: [NSFontAttributeName : UIFont.systemFontOfSize(24.0)]
        )
        let title = NSMutableAttributedString()
        title.appendAttributedString(name)
        title.appendAttributedString(NSAttributedString(string: "\n"))
        title.appendAttributedString(subtitle)
        println(title)
        self.titleLabel?.attributedText = title
        
        self.aboutText?.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "aboutPan:"))
        self.aboutText?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "aboutTap:"))
        self.aboutText?.textColor = UIColor.darkTextColor()
        
        let aboutTitle = NSAttributedString(
            string: "About",
            attributes: [NSFontAttributeName : UIFont.systemFontOfSize(36.0)]
        )
        let aboutSubtitle = NSAttributedString(
            string: self.ship["about"] as! String,
            attributes: [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
        )
        let about = NSMutableAttributedString()
        about.appendAttributedString(aboutTitle)
        about.appendAttributedString(NSAttributedString(string: "\n\n"))
        about.appendAttributedString(aboutSubtitle)
        self.aboutText?.attributedText = about
        */
    }
    
    func tapSponsor(gesture: UIGestureRecognizer) {
        let sponsorAddress = self.ship["sponsorAddress"] as? String
        UIApplication.sharedApplication().openURL(NSURL(string: sponsorAddress!)!)
    }
    
    /*
    override func viewDidLayoutSubviews() {
        if self.height == 0 {
            self.height = self.view.bounds.size.height
            self.aboutTextTop?.constant = self.aboutOpenOffset()
        }
    }
    
    func aboutOpenOffset() -> CGFloat {
        return self.height - 130
    }
    
    func aboutTap(recognizer:UIPanGestureRecognizer) {
        if (self.aboutTextTop?.constant == 0) {
            //nothing to do
        }
        else {
            self.aboutTextTop?.constant = 0
            self.view.updateConstraintsIfNeeded()
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func aboutPan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        self.aboutTextTop?.constant = self.aboutTextTop!.constant + translation.y
        
        //bound it
        if self.aboutTextTop!.constant < 0 {
            self.aboutTextTop?.constant = 0
        }
        else if self.aboutTextTop!.constant >= self.height {
            self.aboutTextTop?.constant = self.aboutOpenOffset()
        }
        println(self.aboutTextTop?.constant)
        
        if recognizer.state == UIGestureRecognizerState.Ended ||
            recognizer.state == UIGestureRecognizerState.Cancelled  {
                if self.aboutTextTop?.constant < self.height/2 {
                    self.aboutTextTop?.constant = 0
                }
                else {
                    self.aboutTextTop?.constant = self.aboutOpenOffset()
                }
        }
        
        self.view.updateConstraintsIfNeeded()
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    */
}

