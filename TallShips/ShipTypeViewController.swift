//
//  TypeViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 6/26/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse

class ShipTypeViewController : ShipPageViewController {
    
    @IBOutlet weak var typeLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.typeLabel?.text = self.ship["shipType"] as? String
    }
}
