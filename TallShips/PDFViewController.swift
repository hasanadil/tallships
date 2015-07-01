//
//  PDFViewController.swift
//  TallShips
//
//  Created by Hasan Adil on 7/1/15.
//  Copyright (c) 2015 Hasan Adil. All rights reserved.
//

import UIKit
import Parse

class PDFViewController: UIViewController {
    
    @IBOutlet weak var webview: UIWebView?
    
    var object = nil as PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webview?.backgroundColor = UIColor.whiteColor()
        self.view.backgroundColor = UIColor.whiteColor()
        
        if let object = self.object {
            let title = object["title"] as? String
            self.navigationItem.title = title

            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            var documentsDir = paths.firstObject as! String
            if documentsDir.hasSuffix("/") == false {
               documentsDir = documentsDir + "/"
            }
            let filePath = documentsDir + title! + ".pdf"
            println(filePath)
                        
            let fileManager = NSFileManager.defaultManager() as NSFileManager
            if fileManager.fileExistsAtPath(filePath) {
                let fileUrl = NSURL.fileURLWithPath(filePath) as NSURL?
                self.webview?.loadRequest(NSURLRequest(URL: fileUrl!))
            }
            else {
                let pdfFile = object["pdf"] as? PFFile
                if let pdfFile = pdfFile {
                    pdfFile.getDataInBackgroundWithBlock { (data, error) -> Void in
                        if let pdfData = data as NSData? {
                            pdfData.writeToFile(filePath, atomically: true)
                            
                            let fileUrl = NSURL.fileURLWithPath(filePath) as NSURL?
                            self.webview?.loadRequest(NSURLRequest(URL: fileUrl!))
                        }
                    }
                }
            }
        }        
    }
}
