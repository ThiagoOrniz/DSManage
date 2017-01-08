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
    
    @IBOutlet weak var clientsView: UIView!
    @IBOutlet weak var productsView: UIView!
    @IBOutlet weak var salesView: UIView!
    @IBOutlet weak var reportsView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let clientsTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let productsTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let salesTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        let reportsTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        self.clientsView.addGestureRecognizer(clientsTap)
        self.productsView.addGestureRecognizer(productsTap)
        self.salesView.addGestureRecognizer(salesTap)
        self.reportsView.addGestureRecognizer(reportsTap)
        
    }
    
    func handleTap(_ sender: UITapGestureRecognizer){
        
        let currentView: UIView = sender.view as UIView!
        
        currentView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
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
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            currentView.backgroundColor = #colorLiteral(red: 0.9531012177, green: 0.9531235099, blue: 0.9531114697, alpha: 1)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
