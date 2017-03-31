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
    
    var loginViewModel = LoginViewModel()
    var disposeBag = DisposeBag()
    private lazy var loadingAlertController = UIAlertController()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        loginButton.layer.cornerRadius = 5
        addHideKeyboardWhenTapped()
        scrollView.registerForKeyboardNotifications()

        setupRxObjects()
    }

    private func setupTextFields(){
        
        emailTextField.setAccessoryBar(with: passwordTextField)
        passwordTextField.setAccessoryBar(with: nil)
    }
    
    private func setupRxObjects(){
        
        
        passwordTextField.rx.text.map{$0}
            .bindNext({ [weak self] password in
                self?.loginViewModel.password.value = password ?? ""
            })
            .addDisposableTo(disposeBag)
        
        emailTextField.rx.text.map{$0}
            .bindNext({ [weak self] email in
                self?.loginViewModel.email.value = email ?? ""
            })
            .addDisposableTo(disposeBag)
        
        
        loginViewModel.error
            .bindNext({ [weak self] error in
                
                self?.loadingAlertController.dismiss(animated: true, completion: {
                    self?.showOkAlertMessage(withTitle: "Não foi possível entrar no sistema", andBody: error)
                })
            })
            .addDisposableTo(disposeBag)

    }
    
    @IBAction func loginButtonTouched(_ sender: UIButton) {
     
        _ = loginViewModel.isValid
            .observeOn(MainScheduler.instance)
            .take(1)
            .subscribe(onNext: { [weak self] (email, password) in
                
                if !email {
                    self?.showMessageInvalidEmail()
                    return
                } else if !password {
                    self?.showMessageInvalidPassword()
                    return
                }
                
                
                
            }, onError: { (error) in
                    print(error)
            }, onCompleted: {
                print("complete")
            })
    }
    
    
    private func showMessageInvalidEmail() {
        emailTextField.becomeFirstResponder()
        showOkAlertMessage(withTitle: "Email inválido", andBody: "Por favor, digite um email válido.")
    }
    
    private func showMessageInvalidPassword() {
        passwordTextField.becomeFirstResponder()
        showOkAlertMessage(withTitle: "Senha inválida", andBody: "Senha deve conter no mínimo 6 caracteres.")
        
    }
}

