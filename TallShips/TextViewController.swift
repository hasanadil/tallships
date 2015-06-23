//
//  TextViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 6/23/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var textTitle: String = ""
    var text: String = ""
    @IBOutlet weak var textView: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = NSAttributedString(string: self.textTitle,
            attributes: [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)])
        let detail = NSAttributedString(string: self.text,
            attributes: [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)])
        let fullText = NSMutableAttributedString()
        fullText.appendAttributedString(title)
        fullText.appendAttributedString(NSAttributedString(string: "\n\n"))
        fullText.appendAttributedString(detail)
        self.textView?.attributedText = fullText
    }
}
