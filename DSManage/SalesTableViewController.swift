//
//  SalesTableViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 17/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit

class SalesTableViewController: UITableViewController {

    private var sales:[Sale] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let addButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add,target: self,action: #selector(add))
        
        self.navigationItem.rightBarButtonItems = [addButtonItem]
        
    }
    
    func add(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Product", bundle:nil)
        
        let productCollectionViewController = storyBoard.instantiateViewController(withIdentifier: "productCollectionViewController") as! ProductCollectionViewController
        
        self.navigationController?.pushViewController(productCollectionViewController, animated: true)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sales =  SaleService().getSales()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sales.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaleTableViewCell", for: indexPath) as! SaleTableViewCell
        
        
        let sale:Sale = sales[indexPath.row]
        
        cell.clientLabel.text = sale.client.name
        cell.totalLabel.text = String(format:"%.2f",sale.getTotal())
        
    
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sale:Sale = sales[indexPath.row]
        print(sale)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let saleDetailViewController = segue.destination as! SaleDetailViewController
        var selectedIndexPath = self.tableView?.indexPathsForSelectedRows?.first
        saleDetailViewController.setSale(sale: sales[(selectedIndexPath?.row)!])
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
