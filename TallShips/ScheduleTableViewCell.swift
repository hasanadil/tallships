//
//  ScheduleTableViewCell.swift
//  TallShips
//
//  Created by Hasan Adil on 6/23/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Foundation
import Parse

class ScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    func setSchedule(schedule: PFObject) {
        self.titleLabel?.text = schedule["title"] as? String
        self.subtitleLabel?.text = schedule["detail"] as? String
    }    
}
