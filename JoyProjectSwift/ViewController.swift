//
//  ViewController.swift
//  JoyProjectSwift
//
//  Created by zhaizy on 15/3/10.
//  Copyright (c) 2015年 zhaizy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sWidth:CGFloat?
    var sHeight:CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sWidth = self.view.bounds.width
        sHeight = self.view.bounds.height
        
        let coloredSquare = UIView()
        coloredSquare.backgroundColor = UIColor.blueColor()
        coloredSquare.frame = CGRectMake(0, 120, 50, 50)
        self.view.addSubview(coloredSquare)
      
        let options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat | UIViewAnimationOptions.CurveEaseInOut
        
        UIView.animateWithDuration(1.0,delay:0.0,options:options, animations: {
            coloredSquare.backgroundColor = UIColor.redColor()
            coloredSquare.frame = CGRectMake(self.sWidth!-50, 120, 50, 50)
            },completion:{finished in println("it is end!")})
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

