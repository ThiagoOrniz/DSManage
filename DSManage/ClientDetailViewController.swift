//
//  ClientDetailViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class ClientDetailViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var clientScrollView: UIScrollView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var numberOfSalesLabel: UILabel!
    @IBOutlet weak var totalOfSalesLabel: UILabel!
    
    private let imagePicker = UIImagePickerController()
    private var isEditingClient = false
    private var client = Client();
    private var tapRecognizer:UITapGestureRecognizer = UITapGestureRecognizer()

    
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
        if(isEditingClient){
            populateView()
        }
    }

    private func setupNavigationController(){
        
        let saveButtomItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save,target: self,action: #selector(saveButtonTouched))
        
        self.navigationItem.setRightBarButton(saveButtomItem, animated: true)
    }
    
    private func setupTextFields(){
        
        let emptyTextField = UITextField()
        emptyTextField.placeholder = "-1"
        
        nameTextField.inputAccessoryView = nameTextField.setAccessoryView(textField: nameTextField, nextTextField: phoneTextField)
       
        phoneTextField.inputAccessoryView = phoneTextField.setAccessoryView(textField: phoneTextField, nextTextField:emailTextField )
        
        emailTextField.inputAccessoryView = emailTextField.setAccessoryView(textField: emailTextField, nextTextField: addressTextField)
        
        addressTextField.inputAccessoryView = addressTextField.setAccessoryView(textField: addressTextField, nextTextField:emptyTextField )
    }
    
    private func setupAvatarImage(){
        
        let changeAvatarTap = UITapGestureRecognizer(target: self, action: #selector(self.handleAvatarTap(_:)))
        self.avatarImageView.addGestureRecognizer(changeAvatarTap)
        
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
        self.avatarImageView.clipsToBounds = true;
    }
  
    private func setupScrollView(){
        clientScrollView.registerForKeyboardDidShowNotification(scrollView: clientScrollView)
        clientScrollView.registerForKeyboardWillHideNotification(scrollView: clientScrollView)
    }
    
    func hikeKeyboard(){
        self.view.endEditing(true)
    }
    
    public func setClient(client:Client, isEditingClient:Bool){
        self.client = client
        self.isEditingClient = isEditingClient
        
    }
    
    
    private func populateView(){
        self.nameTextField.text = self.client.name
        self.emailTextField.text = self.client.email
        self.phoneTextField.text = self.client.phone
        self.addressTextField.text = self.client.address
    }
    
    func saveButtonTouched(){
        print("OI")
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

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        avatarImageView.image = image
        
        self.dismiss(animated: true, completion: nil);

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {

        avatarImageView.image = image
        self.dismiss(animated: true, completion: nil);
    }

    private func showImage(){
        //todo show image detailed
    }
    
    private func openCamera(){

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        else{
            let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true,completion: nil)
        }
    }
    
    private func openLibrary(){

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        else{
            let alertVC = UIAlertController(title: "No Library",message: "Sorry, this device couldn't open the library",preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            self.present( alertVC,animated: true,completion: nil)
        }

    }
    
    @IBAction func emailButtonTouched(_ sender: UIButton) {
        //todo email
    }
    
    @IBAction func deleteButtonTouched(_ sender: UIButton) {
        // todo deletebutton
    }
    
    @IBAction func sellButtonTouched(_ sender: UIButton) {
        //todo open sell
    }
    
}
