//
//  JoyListController.swift
//  JoyProjectSwift
//
//  Created by zhaizy on 15/3/17.
//  Copyright (c) 2015年 zhaizy. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class JoyListController:UIViewController,UITableViewDataSource,UITableViewDelegate {
    
//    http://myphp520.duapp.com/myphp/index.php?r=/site/readfile
//    String path = Constant.url + "/site/readfile";
//    params.put("uid", uid);
//    params.put("type", type);
//    params.put("page", page + "");
//    params.put("pagesize", pageSize + "");
    
    @IBOutlet weak var joyTableView: UITableView!

//    var joyList:[String] = ["测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试pthie is not good,you kown !?","测试q","测试q","测试q","测试q","测试q","测试q","测试q","测试q","测试q","测试q","测试q","测试q","测试q"]
    
    var joyItems:[JoyItem] = []
    
    let url = "http://myphp520.duapp.com/myphp/index.php?r=/site/readfile"
    
     var request = HTTPTask()
    
    
    var refreshControl:UIRefreshControl?
    
    var joyContentCell:JoyContentTableViewCell!
    
     override func viewDidLoad() {
         super.viewDidLoad()
     
        
        var nib = UINib(nibName: "JoyContentCell", bundle: nil)
        self.joyTableView.registerNib(nib, forCellReuseIdentifier: "JoyContentCell")
        
        joyContentCell = self.joyTableView.dequeueReusableCellWithIdentifier("JoyContentCell") as! JoyContentTableViewCell
        
        self.joyTableView.dataSource = self
        self.joyTableView.delegate = self
        
        self.joyTableView.estimatedRowHeight = 44.0
        self.joyTableView.rowHeight = UITableViewAutomaticDimension
        
        
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl!.addTarget(self, action: "loadDataSource", forControlEvents: UIControlEvents.ValueChanged)
        
        self.joyTableView.addSubview(refreshControl!)
        
        refreshControl?.beginRefreshing()
    
        loadDataSource()
    }
    
    func loadDataSource(){
        println("loading data")

        let params = ["page":"1","pagesize":"15","type":"3"]
        request.POST(url, parameters: params, success: {(response: HTTPResponse) in
            
            
            if let dataFromString = response.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                
                let json:JSON = JSON(data: dataFromString)
                var code = json["code"]
                var msg = json["message"]
                var jsonarray = json["data"].arrayValue
                
                println("post success:\(code),\(msg)")
                for joyItem in jsonarray {
                    println("data:\(joyItem)")
                    var item = JoyItem()
                    item.author = joyItem["author"].string
                    item.content = joyItem["content"].string
                    item.title = joyItem["title"].string
                    item.image = joyItem["image"].string
                    println("the title is \(item.title!)")
                    self.joyItems.append(item)
                }
                println("the count is \(self.joyItems.count)")
                self.joyTableView!.reloadData()
                
                 self.refreshControl!.endRefreshing()
                
            }
            
            },failure: {(error: NSError, response: HTTPResponse?) in
            println("post error:\(response)")
                
        })
        
    }
    
    func didReceiveAPIResults(results: NSDictionary){
        print("@@## didReceiveAPIResults:\(results) ")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return joyItems.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        var identifierCell = "JoyContentCell"
        var cell = self.joyTableView.dequeueReusableCellWithIdentifier(identifierCell,forIndexPath:indexPath) as! JoyContentTableViewCell
        var title = joyItems[indexPath.item].title!
        if title == "" {
            title = "空的标题啊:"
        }
        
        var image = UIImage(named: "2")!
//        if image.size.width > 80 {
//            
//        }
       
        cell.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(cell.titleLabel.frame)
        cell.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth(cell.contentLabel.frame)
        cell.titleLabel.text = title+String(stringInterpolationSegment: cell.frame.size.height)
        var content:String = joyItems[indexPath.item].content!
        if content=="" {
            cell.contentLabel.hidden = true
            cell.joyImage.hidden = false
             cell.contentLabel.text = nil
            image = image.resizeToSize(CGSizeMake(80, image.size.height * (80 / image.size.width)))
        }else {
            cell.joyImage.hidden = true
            cell.contentLabel.hidden = false
            cell.contentLabel.text = content
            image = image.resizeToSize(CGSizeMake(80, 10))
        }
        
         cell.joyImage.image = image


//
       // cell.setNeedsUpdateConstraints()
       // cell.updateConstraintsIfNeeded()
        
//        println("cellForRowAtIndexPath:\(cell.frame.size.height)")
        
        return cell
    }
    
//     func tableView(tableView:UITableView,estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = joyContentCell
////        cell!.titleLabel.text = joyItems[indexPath.item].title!
//        var content:String = joyItems[indexPath.item].content!
//        var h:CGFloat = 0
////        if content == "" {
////            h = cell!.joyImage.frame.height+cell!.titleLabel.frame.height+1
////        }else {
////           h = cell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
////        }
//        cell!.contentLabel.text = content
//        var size:CGSize = cell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//       h = size.height
//       
//        println("the estimatedHeight is \(h)")
//       // return h
//     return 10
//    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//    
//            let cell = joyContentCell
//            cell!.titleLabel.text = joyItems[indexPath.item].title!
//            var content:String = joyItems[indexPath.item].content!
//            var h:CGFloat = 0
//                h = cell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
//        
//            
//            println("the heightForRowAtIndexPath is \(h)")
//            return h
//        
//
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var text = joyItems[indexPath.item].title
        println("click item \(text)")
        
        var storyboard = UIStoryboard(name: "testAutoLayout", bundle: NSBundle.mainBundle())
        
        
        var autolayoutController = storyboard.instantiateViewControllerWithIdentifier("testAutoLayout") as! AutoLayoutTestController
        self.navigationController!.pushViewController(autolayoutController, animated: false)
    }
    
}
