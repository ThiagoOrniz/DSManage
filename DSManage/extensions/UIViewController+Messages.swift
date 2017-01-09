//
//  UIViewController+Messages.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    func showOkAlertMessage(withTitle title:String, andBody body:String) {

        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
