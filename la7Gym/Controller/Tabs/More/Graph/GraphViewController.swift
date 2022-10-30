//
//  GraphViewController.swift
//  la7Gym
//
//  Created by Mohamed on 24/09/2021.
//

import UIKit
import Charts

class GraphViewController: UIViewController {

    @IBOutlet weak var viewWeight: UIView!
    @IBOutlet weak var viewBodyFat: UIView!
    @IBOutlet weak var viewMuscle: UIView!
    @IBOutlet weak var viewFatMass: UIView!
    @IBOutlet weak var viewCurrent: UIView!
    @IBOutlet weak var labelCurrent: UILabel!
    @IBOutlet weak var viewStart: UIView!
    @IBOutlet weak var labelStart: UILabel!
    @IBOutlet weak var labelSelected: UILabel!
    @IBOutlet weak var viewGrapg: LineChartView!
    @IBOutlet weak var stackView: UIStackView!
    
    var arrayWeight = [GraphModel]()
    var arrayBodyFat = [GraphModel]()
    var arrayMucles = [GraphModel]()
    var arrayFatMass = [GraphModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        getData()
        GoogleAnalyticsHandler.instance.screenView(screenName: "GraphVC")
    }
    
    func getData() {
        showIndicator()
        AppConnectionsHandler.get(url: AppUrl.instance.getGraph(), headers: GET_DEFAULT_HEADERS(), type: UserGraphResponseModel.self) { (status, model, error) in
            self.showIndicator(false)
            switch status {
            case .sucess:
                let model = model as! UserGraphResponseModel
                self.arrayWeight = model.weight ?? [GraphModel]()
                self.arrayMucles = model.muscle_mass ?? [GraphModel]()
                self.arrayBodyFat = model.body_fat ?? [GraphModel]()
                self.arrayFatMass = model.fat_mass ?? [GraphModel]()
                self.chooseWeight()
                break
            case .error:
//                AppPopUpHandler.instance.initHintPopUp(container: self, message: error ?? "")
                break
            }
        }
    }
    
    func initViews() {
        viewWeight.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseWeight)))
        viewBodyFat.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseBodyFat)))
        viewMuscle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseMuscle)))
        viewFatMass.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseFatMass)))
        viewCurrent.layer.cornerRadius = 10
        viewStart.layer.cornerRadius = 10
    }
    
    func clearViews() {
        viewWeight.backgroundColor = .clear
        viewWeight.setBorder(color: .fromHex(hex: "#363636"), radius: 10, borderWidth: 2)
        viewBodyFat.backgroundColor = .clear
        viewBodyFat.setBorder(color: .fromHex(hex: "#363636"), radius: 10, borderWidth: 2)
        viewMuscle.backgroundColor = .clear
        viewMuscle.setBorder(color: .fromHex(hex: "#363636"), radius: 10, borderWidth: 2)
        viewFatMass.backgroundColor = .clear
        viewFatMass.setBorder(color: .fromHex(hex: "#363636"), radius: 10, borderWidth: 2)
    }
    
    @objc func chooseWeight() {
        clearViews()
        viewWeight.backgroundColor = .fromHex(hex: "#1E988A")
        labelSelected.text = "Weight"
        labelStart.text = "\(arrayWeight.first?.value ?? "") \(arrayWeight.first?.symbol ?? "")"
        labelCurrent.text = "\(arrayWeight.last?.value ?? "") \(arrayWeight.last?.symbol ?? "")"
        initChart2(arrayWeight)
    }
    
    @objc func chooseBodyFat() {
        clearViews()
        viewBodyFat.backgroundColor = .fromHex(hex: "#1E988A")
        labelSelected.text = "Body Fat"
        labelStart.text = "\(arrayBodyFat.first?.value ?? "") \(arrayBodyFat.first?.symbol ?? "")"
        labelCurrent.text = "\(arrayBodyFat.last?.value ?? "") \(arrayBodyFat.last?.symbol ?? "")"
        initChart2(arrayBodyFat)
    }

    @objc func chooseMuscle() {
        clearViews()
        viewMuscle.backgroundColor = .fromHex(hex: "#1E988A")
        labelSelected.text = "Muscle Mass"
        labelStart.text = "\(arrayMucles.first?.value ?? "") \(arrayMucles.first?.symbol ?? "")"
        labelCurrent.text = "\(arrayMucles.last?.value ?? "") \(arrayMucles.last?.symbol ?? "")"
        initChart2(arrayMucles)
    }
    
    @objc func chooseFatMass() {
        clearViews()
        viewFatMass.backgroundColor = .fromHex(hex: "#1E988A")
        labelSelected.text = "Fat Mass"
        labelStart.text = "\(arrayFatMass.first?.value ?? "") \(arrayFatMass.first?.symbol ?? "")"
        labelCurrent.text = "\(arrayFatMass.last?.value ?? "") \(arrayFatMass.last?.symbol ?? "")"
        initChart2(arrayFatMass)
    }
    
    func initChart(_ array: [GraphModel]) {
        viewGrapg.chartDescription?.enabled = true
        viewGrapg.dragEnabled = false
        viewGrapg.setScaleEnabled(false)
        viewGrapg.pinchZoomEnabled = false
        
        viewGrapg.xAxis.gridLineDashLengths = [10, 10]
        viewGrapg.xAxis.gridLineDashPhase = 0
        
        let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = ChartLimitLine.LabelPosition.topRight
        ll1.valueFont = .systemFont(ofSize: 10)

        let ll2 = ChartLimitLine(limit: 0, label: "Lower Limit")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = ChartLimitLine.LabelPosition.bottomRight
        ll2.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = viewGrapg.leftAxis
        leftAxis.removeAllLimitLines()
//        leftAxis.addLimitLine(ll1)
//        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 200
        leftAxis.axisMinimum = 0
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true

        viewGrapg.rightAxis.enabled = false
//
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = viewGrapg
        marker.minimumSize = CGSize(width: 80, height: 40)
        viewGrapg.marker = marker

        viewGrapg.legend.form = .line

//        sliderX.value = 45
//        sliderY.value = 100
//        slidersValueChanged(nil)

        var arr = [Int]()
        for item in array {
            arr.append(Int(item.value ?? "0") ?? 0)
        }
        setDataCount(arr)
        
        viewGrapg.animate(xAxisDuration: 1)

    }
    
    func setDataCount(_ arr: [Int]) {
        var index = 0
        let values = (0..<arr.count).map { (i) -> ChartDataEntry in
            let val = arr[index]
            index += 1
            return ChartDataEntry(x: Double(i), y: Double(val), icon: #imageLiteral(resourceName: "Group 1383"))
        }

        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.drawIconsEnabled = false
        setup(set1)

//        let value = ChartDataEntry(x: Double(3), y: 3)
//        set1.addEntryOrdered(value)
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        set1.fillAlpha = 1
//        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)

        viewGrapg.data = data
    }
    
    private func setup(_ dataSet: LineChartDataSet) {
        dataSet.lineDashLengths = nil
        dataSet.highlightLineDashLengths = nil
        dataSet.setColors(.white, .red, .white)
        dataSet.setCircleColor(.white)
//        dataSet.gradientPositions = [0, 40, 100]
        dataSet.lineWidth = 1
        dataSet.circleRadius = 3
        dataSet.drawCircleHoleEnabled = false
        dataSet.valueFont = .systemFont(ofSize: 8)
        dataSet.formLineDashLengths = nil
        dataSet.formLineWidth = 1
        dataSet.formSize = 15
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

class UserGraphResponseModel: Codable {
    
    let weight: [GraphModel]?
    let body_fat: [GraphModel]?
    let muscle_mass: [GraphModel]?
    let fat_mass: [GraphModel]?
}

extension GraphViewController {
    
    func initChart2(_ array: [GraphModel]) {
        for view in stackView.subviews {
            view.removeFromSuperview()
        }
        for item in array {
            let label = UILabel()
            label.text = item.getDateFormatted()
            label.textColor = .white
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 12)
            stackView.addArrangedSubview(label)
        }
        
//        viewGrapg.delegate = self

        viewGrapg.setViewPortOffsets(left: 0, top: 20, right: 0, bottom: 0)
        viewGrapg.backgroundColor = .clear
        
        viewGrapg.dragEnabled = true
        viewGrapg.setScaleEnabled(true)
        viewGrapg.pinchZoomEnabled = false
        viewGrapg.maxHighlightDistance = 300
        
//        viewGrapg.xAxis.enabled = false
        
        let yAxis = viewGrapg.leftAxis
        yAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size:12)!
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.labelPosition = .insideChart
        yAxis.axisLineColor = .white
        
        
//        let xAxis = viewGrapg.xAxis
//        xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size:12)!
//        xAxis.setLabelCount(array.count, force: false)
//        xAxis.labelTextColor = .white
////        xAxis.labelPosition = .insideChart
//        xAxis.axisLineColor = .white
//        var referenceTimeInterval: TimeInterval = 0
//        if let minTimeInterval = (array.map { $0.getDate().timeIntervalSince1970 }).min() {
//            referenceTimeInterval = minTimeInterval
//        }
//        
//        
//        // Define chart xValues formatter
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .none
//        formatter.locale = Locale.current
//       
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en")
//        dateFormatter.dateFormat = "MM-dd"
//
//        
//        let xValuesNumberFormatter = ChartXAxisFormatter(referenceTimeInterval: referenceTimeInterval, dateFormatter: dateFormatter)
//        xAxis.valueFormatter = xValuesNumberFormatter
        
        viewGrapg.rightAxis.enabled = false
        viewGrapg.legend.enabled = false
        
        var arr = [Int]()
        for item in array {
            arr.append(Int(item.value ?? "0") ?? 0)
        }
        setDataCount2(arr)
        
        viewGrapg.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
    func setDataCount2(_ arr: [Int]) {
        var index = 0
        let values = (0..<arr.count).map { (i) -> ChartDataEntry in
            let val = arr[index]
            index += 1
            return ChartDataEntry(x: Double(i), y: Double(val))
        }
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.mode = .cubicBezier
        set1.lineWidth = 1.8
        set1.circleRadius = 4
        set1.setCircleColor(.white)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.fillColor = .white
        set1.fillAlpha = 1
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.fillFormatter = CubicLineSampleFillFormatter()
        set1.drawCirclesEnabled = true
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.5
        set1.fillColor = .fromHex(hex: "1E988A")
        
        let data = LineChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 9)!)
        data.setDrawValues(false)
        
        viewGrapg.data = data
    }
}

class CubicLineSampleFillFormatter: IFillFormatter {
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10
    }
}

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter?
    fileprivate var referenceTimeInterval: TimeInterval?

    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
        self.init()
        self.referenceTimeInterval = referenceTimeInterval
        self.dateFormatter = dateFormatter
    }
}


extension ChartXAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateFormatter = dateFormatter,
        let referenceTimeInterval = referenceTimeInterval
        else {
            return ""
        }

        let date = Date(timeIntervalSince1970: value * 3600 * 24 + referenceTimeInterval)
        return dateFormatter.string(from: date)
    }

}
