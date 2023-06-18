//
//  MyTableViewController.swift
//  chartTest
//
//  Created by CHUN-CHIEH LU on 2022/12/24.
//

import UIKit
import DGCharts

class MyTableViewController: UITableViewController, ChartViewDelegate, AxisValueFormatter {
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        return testData[Int(value)]
    }
    

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var cubicChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    var testData = ["one","two","three","four","five","six"]
    var unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
    let unitsSold2 = [15.0, 10.0, 25.0, 7.0, 6.0, 8.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        barChartView.delegate = self
        barChartView.xAxis.valueFormatter = self
        
        //設定長條圖
        setBarChart(dataPoints: testData, values: unitsSold)
        
        //設定折線圖
        setLineChart(dataPoints: testData, values: unitsSold)
        
        //設定曲線圖
        setCubicBezierChart(dataPoints: testData, values1: unitsSold, values2: unitsSold2)
        
        //設定圓餅圖
        setPieChart(dataPoints: testData, values: unitsSold)
    }


    
    //設定長條圖
    func setBarChart(dataPoints:[String] , values:[Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(x:Double(i), y:values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "測試")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
        chartDataSet.colors = ChartColorTemplates.material()
    }

    //設定折線圖
    func setLineChart(dataPoints: [String], values: [Double])
    {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count
        {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "測試")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData

        lineChartView.xAxis.valueFormatter = self
        lineChartView.xAxis.labelPosition = .bothSided
    }
    
    //設定曲線圖
    func setCubicBezierChart(dataPoints: [String], values1: [Double], values2: [Double])
    {
        var dataEntries1: [ChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count
        {
            let dataEntry1 = ChartDataEntry(x: Double(i), y: values1[i])
            dataEntries1.append(dataEntry1)
            
            let dataEntry2 = ChartDataEntry(x: Double(i), y: values2[i])
            dataEntries2.append(dataEntry2)
        }

        let lineChartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "測試 1")
        let lineChartDataSet2 = LineChartDataSet(entries: dataEntries2, label: "測試 2")
        
        lineChartDataSet1.colors = [.systemGreen]
        lineChartDataSet1.drawCirclesEnabled = false
        lineChartDataSet1.drawValuesEnabled = false
        lineChartDataSet1.mode = .cubicBezier
        
        lineChartDataSet2.colors = [.systemTeal]
        lineChartDataSet2.drawCirclesEnabled = false
        lineChartDataSet2.drawValuesEnabled = false
        lineChartDataSet2.mode = .cubicBezier
    
        let lineChartData = LineChartData(dataSets: [lineChartDataSet1,lineChartDataSet2])
        cubicChartView.data = lineChartData
        
        cubicChartView.xAxis.valueFormatter = self
        cubicChartView.xAxis.labelPosition = .bothSided
    }
    
    //設定圓餅圖
    func setPieChart(dataPoints: [String], values: [Double])
    {
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count
        {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            //ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "測試")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors = [UIColor]()
        for _ in 0..<dataPoints.count
        {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))

            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        pieChartDataSet.colors = colors
    }
}
