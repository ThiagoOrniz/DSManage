//
//  ViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 31/12/16.
//  Copyright © 2016 Thiago Orniz Martin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    var viewModel = LoginViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextFields()
        
        loginButton.layer.cornerRadius = 5
        
        scrollView.registerForKeyboardDidShowNotification(scrollView: scrollView)
        scrollView.registerForKeyboardWillHideNotification(scrollView: scrollView)
    
        let tapRecognizer = UITapGestureRecognizer(target: self, action:  #selector(self.hikeKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
        
        setupRxObjects()
    }

    func hikeKeyboard(){
        self.view.endEditing(true)
    }

    private func setupTextFields(){
        
        emailTextField.setAccessoryBar(with: passwordTextField)
        passwordTextField.setAccessoryBar(with: nil)
    }
    
    private func setupRxObjects(){
        
        passwordTextField.rx.text.map{$0}
            .bindNext({ (password) in
                self.viewModel.password.value = password ?? ""
            })
            .addDisposableTo(disposeBag)
        
        emailTextField.rx.text.map{$0}
            .bindNext({ (email) in
                self.viewModel.email.value = email ?? ""
            })
            .addDisposableTo(disposeBag)
        
        viewModel.isValid
            .asObservable()
            .map{ $0 }
            .bindTo(self.loginButton.rx.isEnabled)
            .addDisposableTo(disposeBag)

    }
    
    @IBAction func loginButtonTouched(_ sender: UIButton) {
        
    }
    

}

