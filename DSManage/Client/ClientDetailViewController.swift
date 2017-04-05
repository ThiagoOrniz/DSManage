//
//  ClientDetailViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class ClientDetailViewController: UIViewController {

    @IBOutlet weak var clientScrollView: UIScrollView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var numberOfSalesLabel: UILabel!
    @IBOutlet weak var totalOfSalesLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    private let imagePicker = UIImagePickerController()
    private var isEditingClient = false
    private var clientViewModel: ClientViewModel!
    
    private var tapRecognizer = UITapGestureRecognizer()

    var avatar = NSData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        setupNavigationController()
        setupTextFields()
        setupAvatarImage()
        setupScrollView()
        
        self.tapRecognizer = UITapGestureRecognizer(target: self, action:  #selector(self.hikeKeyboard))
        self.view.addGestureRecognizer(self.tapRecognizer)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isEditingClient {
            populateView()
        } else {
            statusView.isHidden = true
            emailButton.isHidden = true
            sellButton.isHidden = true
        }
    }

    private func setupNavigationController(){
        
        let saveButtomItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save,target: self,action: #selector(saveButtonTouched))
        
        self.navigationItem.setRightBarButton(saveButtomItem, animated: true)
    }
    
    private func setupTextFields() {
        
        nameTextField.setAccessoryBar(with: phoneTextField)
        phoneTextField.setAccessoryBar(with: emailTextField)
        emailTextField.setAccessoryBar(with: addressTextField)
        addressTextField.setAccessoryBar(with: nil)
    }
    
    private func setupAvatarImage(){
        
        let changeAvatarTap = UITapGestureRecognizer(target: self, action: #selector(self.handleAvatarTap(_:)))
        self.avatarImageView.addGestureRecognizer(changeAvatarTap)
        
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2
        self.avatarImageView.clipsToBounds = true
    }
  
    private func setupScrollView(){
        clientScrollView.registerForKeyboardNotifications()
    }
    
    func hikeKeyboard(){
        self.view.endEditing(true)
    }
    
    public func setClient(_ client:ClientViewModel, isEditingClient:Bool){
        self.clientViewModel = client
        self.isEditingClient = isEditingClient
        
    }
    
    
    private func populateView(){
    
        self.nameTextField.text = self.clientViewModel.nameText
        self.emailTextField.text = self.clientViewModel.emailText
        self.phoneTextField.text = self.clientViewModel.phoneText
        self.addressTextField.text = self.clientViewModel.addressText
//        
        self.avatarImageView.image = UIImage(data: clientViewModel.avatar)
    }
    
    func saveButtonTouched(){
        
        if !isEditingClient {
            clientViewModel = ClientViewModel()
        }
        
        clientViewModel.nameText = nameTextField.text!
        clientViewModel.emailText = emailTextField.text!
        clientViewModel.phoneText = phoneTextField.text!
        clientViewModel.addressText = addressTextField.text!
        
        clientViewModel.avatar = avatar as Data
                
        clientViewModel.saveClient()
        
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    func handleAvatarTap(_ sender: UITapGestureRecognizer){

        let alert = UIAlertController(title: "Change Profile Picture", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Show", style: .default) { action in
            self.showImage()
        })
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { action in
            self.openCamera()
        })
        
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default) { action in
            self.openLibrary()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        self.present(alert,animated: true,completion: nil)
    }

    private func showImage(){
        //todo show image detailed
    }
    
    func openCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        else{
            
            self.showOkAlertMessage(withTitle: "No Camera", andBody: "Sorry, this device has no camera")
        }
    }
    
    func openLibrary(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        else{
            self.showOkAlertMessage(withTitle: "No Library", andBody: "Sorry, this device couldn't open the library")
        }
        
    }
    
    @IBAction func emailButtonTouched(_ sender: UIButton) {
//        let mailComposeViewController = configuredMailComposeViewController()
//        if MFMailComposeViewController.canSendMail() {
//            self.present(mailComposeViewController, animated: true, completion: nil)
//        } else {
//            
//            self.showOkAlertMessage(withTitle: "Could Not Send Email", andBody: "Your device could not send e-mail.  Please check e-mail configuration and try again.")
//        }
    }
    
    @IBAction func deleteButtonTouched(_ sender: UIButton) {
        // todo deletebutton
        
        if !isEditingClient {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        clientViewModel.removeClient()
        _ = self.navigationController?.popViewController(animated: true)

        
    }
    
    @IBAction func sellButtonTouched(_ sender: UIButton) {
        
//        if client != nil {
//            ShoppingCartService.sharedInstance.updateClient(client: client!)
//        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Product", bundle:nil)
        
        let productCollectionViewController = storyBoard.instantiateViewController(withIdentifier: "productCollectionViewController") as! ProductCollectionViewController
        
        self.navigationController?.pushViewController(productCollectionViewController, animated: true)
    }
    
    
//    func configuredMailComposeViewController() -> MFMailComposeViewController {
//        let mailComposerVC = MFMailComposeViewController()
//        mailComposerVC.mailComposeDelegate = self
//        mailComposerVC.setToRecipients([self.client?.email ?? ""])
//        mailComposerVC.setMessageBody("", isHTML: false)
//        return mailComposerVC
//    }
//    
//    
//    // MARK: MFMailComposeViewControllerDelegate Method
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//    
//    private func validate() -> Bool{
//        if(!TextfieldValidator.validateName(nameTextField.text!)){
//          
//            nameTextField.becomeFirstResponder()
//            self.showOkAlertMessage(withTitle: "Invalid Name", andBody: "Please, type at least 2 characters.")
//        
//            return false
//        }
//        
//        if((emailTextField.text?.characters.count)! > 0){
//           
//            if(!TextfieldValidator.validatePassword(emailTextField.text!)){
//                
//                emailTextField.becomeFirstResponder()
//                self.showOkAlertMessage(withTitle: "Invalid email", andBody: "Please, type a valid email.")
//                
//                return false
//            }
//        }
//        
//        return true
//    }
    
}
