//
//  ViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 31/12/16.
//  Copyright © 2016 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var tapRecognizer:UITapGestureRecognizer = UITapGestureRecognizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextFields()
        scrollView.registerForKeyboardDidShowNotification(scrollView: scrollView)
        scrollView.registerForKeyboardWillHideNotification(scrollView: scrollView)
        
        self.tapRecognizer = UITapGestureRecognizer(target: self, action:  #selector(self.hikeKeyboard))
        self.view.addGestureRecognizer(self.tapRecognizer)
    }

    func hikeKeyboard(){
        self.view.endEditing(true)
    }
    
    
    private func setupTextFields(){
        
        let emptyTextField = UITextField()
        emptyTextField.placeholder = "-1"
        
        emailTextField.inputAccessoryView = emailTextField.setAccessoryView(textField: emailTextField, nextTextField: passwordTextField)
        
        passwordTextField.inputAccessoryView = passwordTextField.setAccessoryView(textField: passwordTextField, nextTextField:emptyTextField )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func loginButtonTouched(_ sender: UIButton) {
        
        // todo: remove push
        // add validations
    }
    

}

