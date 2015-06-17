//
//  ShipViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 6/14/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse

class ShipViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var aboutText: UITextView?
    @IBOutlet weak var aboutTextTop: NSLayoutConstraint?
    
    var height = 0 as CGFloat
    
    var index = 0
    var ship = PFObject(className: "Ship") as PFObject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
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
}

