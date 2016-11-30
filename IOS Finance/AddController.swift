//
//  AddController.swift
//  IOS Finance
//
//  Created by 123 on 16/11/1.
//  Copyright © 2016年 123. All rights reserved.
//

import UIKit

class AddController: UITableViewController {

    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var Detail: UILabel!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var topview: UINavigationItem!
    var 状态: String = ""
    var selectedclass: String! = nil
    let classModel = ClassModel()
    let financeModel = FinanceModel()
    var datePickerHidden = true
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        classModel.loadData()
        selectedclass = classModel.ClassList[0].listclass
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
        if segue.identifier == "chooseclass" {
            let Controller = segue.destination as! ClassController
            Controller.selectedClass = Detail.text
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

    /*
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //因为日期选择器的位置在日期显示Label下面。它的位置就是第2个section  和第3个row
        if indexPath.row == 2{
            //用重用的方式获取标识为DatePickerCell的cell
            var cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell")
                as UITableViewCell?
            return cell!
        }else{
            return super.
        }
    }
 */


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


