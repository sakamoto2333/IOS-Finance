//
//  LeftMenu.swift
//  LeftSlideoutMenu
//
//  Created by Robert Chen on 8/5/15.
//  Copyright (c) 2015 Thorn Technologies. All rights reserved.
//

import UIKit

class LeftMenu : UITableViewController {
    
    let menuOptions = ["Open Modal", "Open Push"]
    var classPickerHidden = true
    var startdate = true
    var enddate = true
    var row: IndexPath!
    var datestart: IndexPath!
    var dateend: IndexPath!
    let classmodel = ClassModel()
    
    var classa: String!
    var start: Date!
    var end: Date!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        classmodel.loadData()
        tableView.reloadData()
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
        start = cell.startdate?.date
    }
    
    @IBAction func end(_ sender: AnyObject) {
        let cell = tableView.cellForRow(at: dateend) as! startCell
        end = cell.enddate?.date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clean" {
            if row != nil {
                tableView.cellForRow(at: row)?.accessoryType = .none
                row = nil
            }
        }
        if segue.identifier == "search" {
        }
        startdate = true
        enddate = true
        classPickerHidden = true
        tableView.beginUpdates()
        tableView.endUpdates()
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
