//
//  ShoppingCartViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 15/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    
    @IBOutlet weak var clientImageView: UIImageView!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ChangeClientButtonTouched(_ sender: UIButton) {
        
    }
    
    @IBAction func confirmButtonTouched(_ sender: UIButton) {
        
    }
}
