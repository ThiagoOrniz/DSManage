//
//  ClientDetailUIImagePicker.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 04/04/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

extension ClientDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        avatarImageView.image = image
        
        self.avatar = (UIImagePNGRepresentation(image)! as Data as NSData)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        avatarImageView.image = image
        self.avatar = (UIImagePNGRepresentation(image)! as Data as NSData)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
