//
//  ReportsViewController.swift
//  DSManage
//
//  Created by Thiago Orniz Martin on 18/01/17.
//  Copyright © 2017 Thiago Orniz Martin. All rights reserved.
//

import UIKit
import Charts

class ReportsViewController: UIViewController {

    @IBOutlet weak var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateChartWithData()

    }

    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let data = getData()
        for i in 0..<data.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: data[i])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Sales")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
    }
    
    func getData() -> [Double] {
        
        return [0.2, 0.4, 0.6]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
