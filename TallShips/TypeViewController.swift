//
//  TypeViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 6/26/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse

class TypeViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel?
    
    var index = 0
    var ship = PFObject(className: "Ship") as PFObject
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.typeLabel?.text = self.ship["shipType"] as? String
    }
}
