//
//  UIView+Shadow.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 21/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

extension UIView {
    
    
    func setBorderShadow(shadowOpacity:Float ){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1.5
        
    }
}
