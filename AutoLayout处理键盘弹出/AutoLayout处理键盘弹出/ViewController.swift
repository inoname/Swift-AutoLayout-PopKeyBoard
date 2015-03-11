//
//  ViewController.swift
//  AutoLayout处理键盘弹出
//
//  Created by kouliang on 15/3/11.
//  Copyright (c) 2015年 kouliang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加观察者，监听键盘框架的变化
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardFrameChanged:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardFrameChanged:", name: UIKeyboardWillHideNotification, object: nil)
    }

    /// 键盘变化监听方法
    func keyboardFrameChanged(notification: NSNotification) {
        var height: CGFloat = 0
        var duration = 0.25
        
        if notification.name == UIKeyboardWillChangeFrameNotification {
            let rect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            height = rect.size.height
            
            duration = (notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        }
        
        bottomConstraint.constant = height
        
        UIView.animateWithDuration(duration) {
            self.view.layoutIfNeeded()
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}


extension ViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = String(format: "hello-%d", arguments: [indexPath.row])
        return cell
    }
}

