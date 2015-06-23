//
//  NewsTableViewCell.swift
//  TallShips
//
//  Created by Hasan Adil on 6/21/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Foundation
import Parse

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    func setNews(news: PFObject) {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.titleLabel?.text = news["title"] as? String
        self.subtitleLabel?.text = news["detail"] as? String
    }
}
