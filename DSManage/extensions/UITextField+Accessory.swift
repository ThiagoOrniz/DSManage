//
//  UITextField+Accessory.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

private var nextTextFieldKey: UInt8 = 0 // We still need this boilerplate

extension UITextField{
    
    var nextTextField: UITextField! {
        get {
            return objc_getAssociatedObject(self, &nextTextFieldKey) as? UITextField
        }
        set {
            objc_setAssociatedObject(self, &nextTextFieldKey, newValue, objc_AssociationPolicy(rawValue:1)!)
        }
    }
    
    func setAccessoryView(textField:UITextField, nextTextField:UITextField) ->UIView{
        
        self.nextTextField = nextTextField
        
        let toolbar:UIToolbar = UIToolbar()
        let rect = CGRect(x: textField.frame.origin.x, y: textField.frame.origin.y, width: UIScreen.main.bounds.size.width, height: 44)
        
        toolbar.frame = rect
        
        toolbar.backgroundColor = .white
        
        let title:UILabel = self.setLabelWithTitle(title: textField.placeholder!)
        
        let doneBarButtonItem:UIBarButtonItem = UIBarButtonItem()
        doneBarButtonItem.target = self
        doneBarButtonItem.action = #selector(doneBarButtonItemTouched)
        
        doneBarButtonItem.title = nextTextField.placeholder != "-1" ? "Next":"Done"
        
        let flexible:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        
        var items = [UIBarButtonItem]()
        items.append(flexible)
        items.append(doneBarButtonItem)
        
        toolbar.items = items
        toolbar.addSubview(title)
        toolbar.sizeToFit()
        
        return toolbar
        
    }
    
    func doneBarButtonItemTouched(){
        
        if(self.nextTextField.placeholder == "-1"){
            self.resignFirstResponder()
        }
        else{
            self.nextTextField.becomeFirstResponder()
        }
    }
    
    func setLabelWithTitle(title:String) -> UILabel{
        
        let titleLabel:UILabel = UILabel()
        let rect = CGRect(x: 16, y: 0, width: 200, height: 40)
        
        titleLabel.frame = rect
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.textColor = .darkGray
        
        return titleLabel;
        
    }
    
}
