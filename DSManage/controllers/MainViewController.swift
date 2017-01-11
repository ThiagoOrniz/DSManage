//
//  MainViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 08/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let CLIENTS_TAG = 0
    let PRODUCTS_TAG = 1
    let SALES_TAG = 2
    let REPORTS_TAG = 3
    
    @IBOutlet weak var reportsImageView: UIImageView!
    @IBOutlet weak var saleImageView: UIImageView!
    @IBOutlet weak var clientsImageView: UIImageView!
    @IBOutlet weak var productsImageView: UIImageView!
    
    @IBOutlet weak var clientsView: UIView!
    @IBOutlet weak var productsView: UIView!
    @IBOutlet weak var salesView: UIView!
    @IBOutlet weak var reportsView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let clientLongPressRecognizer = UILongPressGestureRecognizer(target: self, action:  #selector(self.handleLongHold(_:)))
        clientLongPressRecognizer.minimumPressDuration = 0
    
        let productLongPressRecognizer = UILongPressGestureRecognizer(target: self, action:  #selector(self.handleLongHold(_:)))
        productLongPressRecognizer.minimumPressDuration = 0
        
        let saleLongPressRecognizer = UILongPressGestureRecognizer(target: self, action:  #selector(self.handleLongHold(_:)))
        saleLongPressRecognizer.minimumPressDuration = 0
        
        let reportLongPressRecognizer = UILongPressGestureRecognizer(target: self, action:  #selector(self.handleLongHold(_:)))
        reportLongPressRecognizer.minimumPressDuration = 0
        
        self.clientsView.addGestureRecognizer(clientLongPressRecognizer)
        self.productsView.addGestureRecognizer(productLongPressRecognizer)
        self.salesView.addGestureRecognizer(saleLongPressRecognizer)
        self.reportsView.addGestureRecognizer(reportLongPressRecognizer)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupImageView()
        setupBorderView()
    
    }
    
    private func setupImageView(){
        setImageViewColor(imageView: clientsImageView)
        setImageViewColor(imageView: productsImageView)
        setImageViewColor(imageView: saleImageView)
        setImageViewColor(imageView: reportsImageView)
    }
    
    private func setupBorderView(){
        setBorderShadow(forView: clientsView, shadowOpacity: 0.3)
        setBorderShadow(forView: productsView, shadowOpacity: 0.3)
        setBorderShadow(forView: salesView, shadowOpacity: 0.3)
        setBorderShadow(forView: reportsView, shadowOpacity: 0.3)
    }

    private func setImageViewColor(imageView:UIImageView){
        imageView.image = imageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.5058823529, green: 0.6980392157, blue: 0.8980392157, alpha: 1)
    }
    
    private func setBorderShadow(forView view:UIView, shadowOpacity:Float ){
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1.5

    }

    func handleLongHold(_ sender: UITapGestureRecognizer){
        let currentView: UIView = sender.view as UIView!

        // handle touch down and touch up events separately
        if sender.state == .began {
            setBorderShadow(forView: currentView, shadowOpacity: 0.8)

        }
        else if  sender.state == .ended {
            
            switch currentView.tag {
            case CLIENTS_TAG:
                self.performSegue(withIdentifier: "pushClients", sender: self)
                
            case PRODUCTS_TAG:
                self.performSegue(withIdentifier: "pushProducts", sender: self)
                
            case SALES_TAG:
                self.performSegue(withIdentifier: "pushSales", sender: self)
                
            case REPORTS_TAG:
                self.performSegue(withIdentifier: "pushReports", sender: self)
                
            default:
                print("error")
                //add validation
            }

            setBorderShadow(forView: currentView, shadowOpacity: 0.3)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
