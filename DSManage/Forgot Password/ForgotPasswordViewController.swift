//
//  ForgotPasswordViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit
import RxSwift

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    private var disposeBag = DisposeBag()
    private var viewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.layer.cornerRadius = 5
        emailTextField.setAccessoryBar(with: nil)
        addHideKeyboardWhenTapped()

        setupRxObjects()
    }

    private func setupRxObjects(){
        
        emailTextField.rx.text.map{$0}
            .bindNext({ [weak self] email in
                self?.viewModel.email.value = email ?? ""
            })
            .addDisposableTo(disposeBag)
        
        
        viewModel.callbackMessage
            .bindNext({ [weak self] (callbackMessage) in
                self?.showOkAlertMessage(withTitle: callbackMessage, andBody: "")
            })
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func sendButtonTouched(_ sender: UIButton) {
        
        _ = viewModel.isValid
            .observeOn(MainScheduler.instance)
            .take(1)
            .subscribe(onNext: { [weak self] (isEmailValid) in
                
                if !isEmailValid {
                    self?.showMessageInvalidEmail()
                    return
                }
                self?.viewModel.sendEmail()

            })
    }
    
    private func showMessageInvalidEmail() {
        emailTextField.becomeFirstResponder()
        showOkAlertMessage(withTitle: "Email inválido", andBody: "Por favor, digite um email válido.")
    }
    
    @IBAction func cancelButtonTouched(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
