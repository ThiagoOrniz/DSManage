//
//  UIScrollView+KeyboardNotification.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func registerForKeyboardNotifications() {
        keyboardDidShow()
        keyboardWillHide()
    }
    
    private func keyboardDidShow() {
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.UIKeyboardDidShow,
            object: nil,
            queue: nil,
            using: { [weak self] (notification) -> Void in
                let userInfo = notification.userInfo!
                let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
                let contentInsets = UIEdgeInsetsMake(self?.contentInset.top ?? 0, self?.contentInset.left ?? 0, keyboardSize.height, self?.contentInset.right ?? 0)
            
                self?.setContentInsetAndScrollIndicatorInsets(edgeInsets: contentInsets)
            }
        )
    }
    
    private func keyboardWillHide() {
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.UIKeyboardWillHide,
            object: nil,
            queue: nil,
            using: { [weak self] (notification) -> Void in
                let contentInsets = UIEdgeInsetsMake(self?.contentInset.top ?? 0, self?.contentInset.left ?? 0, 0, self?.contentInset.right ?? 0)
                self?.setContentInsetAndScrollIndicatorInsets(edgeInsets: contentInsets)
            }
        )
    }
    
    private func setContentInsetAndScrollIndicatorInsets(edgeInsets: UIEdgeInsets)
    {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}
