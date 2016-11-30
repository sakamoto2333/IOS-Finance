//
//  DetailController.swift
//  IOS Finance
//
//  Created by 123 on 16/11/15.
//  Copyright © 2016年 123. All rights reserved.
//

import UIKit

class DetailController: UITableViewController {

    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var Detail: UILabel!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var DatePicker: UIDatePicker!
    var selectedclass: String! = nil
    let financeModel = FinanceModel()
    let classModel = ClassModel()
    var datePickerHidden = true
    var numberrow: Int = 0
    
    func datePickerChanged() {
        // 5.1设置DetaiLabel的文本为UIDatePicker控件所选中的内容, 并且设置选中的日期和时间样式.
        date.text = DateFormatter.localizedString(from: DatePicker.date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
    }
    
    //点击空白收起键盘
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            text.resignFirstResponder()
            number.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    @IBAction func 完成(_ sender: AnyObject) {
        text.resignFirstResponder()
    }
    
    @IBAction func Save(_ sender: AnyObject) {
        print(Detail.text)
        financeModel.FinanceList[numberrow] = FinanceInfo(content: text.text!, date: DateFormatter.localizedString(from: DatePicker.date, dateStyle: .short, timeStyle: .short), money: number.text!, listclass: Detail.text!, situation: financeModel.FinanceList[numberrow].situation)
        financeModel.saveData()
        text.resignFirstResponder()
        number.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        financeModel.loadData()
        number.text = financeModel.FinanceList[numberrow].money
        let a = DateFormatter()
        a.dateStyle = .short
        a.timeStyle = .short
        DatePicker.date = a.date(from: financeModel.FinanceList[numberrow].date)!
        selectedclass = financeModel.FinanceList[numberrow].listclass
        text.text = financeModel.FinanceList[numberrow].content
        Detail.text = selectedclass
        date.text = DateFormatter.localizedString(from: DatePicker.date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        classModel.loadData()
        Detail.text = selectedclass
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    @IBAction func selected(segue:UIStoryboardSegue) {
        let Controller = segue.source as! ClassController
        print(Controller.selectedClass)
        Detail.text = Controller.selectedClass
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeclass" {
            let Controller = segue.destination as! ClassController
            Controller.selectedClass = Detail.text
            Controller.detail = true
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            toggleDatepicker()
        }
    }
    
    @IBAction func datePickerValue(_ sender: UIDatePicker) {
        // 8.1每当点击UIDatePicker, 就调用下面的方法
        datePickerChanged()
    }
    
    func toggleDatepicker() {
        // 7.1当自定义切换方法被调用, 那么自定义的Bool参数就更改成true或者false状态
        datePickerHidden = !datePickerHidden
        // 7.2开始更新当前的TableView
        tableView.beginUpdates()
        
        // 7.3结束更新当前的TableView
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerHidden && indexPath.row == 2 {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
}
