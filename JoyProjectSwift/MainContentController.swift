//
//  MainContentController.swift
//  JoyProjectSwift
//
//  Created by zhaizy on 15/3/12.
//  Copyright (c) 2015年 zhaizy. All rights reserved.
//

import UIKit

class MainContentController: UITabBarController {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if self.revealViewController() != nil {
            println("viewDidLoad")
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
