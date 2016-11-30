//
//  ViewController.swift
//  IOS Finance
//
//  Created by 123 on 16/11/4.
//  Copyright © 2016年 123. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {

    
    var classPickerHidden = true
    var startdate = true
    var enddate = true
    var row: IndexPath!
    var classa: String!
    var start: String!
    var end: String!
    var datestart: IndexPath!
    var dateend: IndexPath!
    let classmodel = ClassModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        classmodel.loadData()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 5
        }
        else {
            return classmodel.ClassList.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "mdzz0", for: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "mdzz1", for: indexPath) as! startCell
                datestart = indexPath
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "mdzz2", for: indexPath)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "mdzz3", for: indexPath) as! startCell
                dateend = indexPath
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "mdzz4", for: indexPath)
                return cell
            }
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "allclass", for: indexPath)
            cell.textLabel?.text = classmodel.ClassList[indexPath.row].listclass
            return cell
        }
    }
    
    @IBAction func start(_ sender: AnyObject) {
        let cell = tableView.cellForRow(at: datestart) as! startCell
        start = DateFormatter.localizedString(from: (cell.startdate?.date)!, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
        print(start)
    }
    
    @IBAction func end(_ sender: AnyObject) {
        let cell = tableView.cellForRow(at: dateend) as! startCell
        end = DateFormatter.localizedString(from: (cell.enddate?.date)!, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.short)
        print(end)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                classpicker(row: 0)
            case 2:
                classpicker(row: 2)
            case 4:
                classpicker(row: 4)
            default:
                break
            }
        }
        else if indexPath.section == 1 {
            if row != nil {
                tableView.cellForRow(at: row)?.accessoryType = .none
            }
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            row = indexPath
            classa = tableView.cellForRow(at: indexPath)?.textLabel?.text
            print(classa)
        }
    }
    
    func classpicker(row: Int) {
        switch row {
        case 0:
            startdate = !startdate
        case 2:
            enddate = !enddate
        case 4:
            classPickerHidden = !classPickerHidden
        default:
            break
        }
        // 7.2开始更新当前的TableView
        tableView.beginUpdates()
        // 7.3结束更新当前的TableView
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (classPickerHidden && indexPath.section == 1) || (startdate && indexPath.section == 0 && indexPath.row == 1) || (enddate && indexPath.section == 0 && indexPath.row == 3){
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }

}
