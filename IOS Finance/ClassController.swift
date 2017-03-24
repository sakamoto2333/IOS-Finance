//
//  ClassController.swift
//  IOS Finance
//
//  Created by 123 on 16/11/1.
//  Copyright © 2016年 123. All rights reserved.
//

import UIKit

class ClassController: UITableViewController,UIGestureRecognizerDelegate,UISearchBarDelegate {

    let classModel = ClassModel()
    let financeModel = FinanceModel()
    var selectedClass: String!
    var detail: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(LongPress))
        longPress.delegate = self
        longPress.minimumPressDuration = 0.5
        self.tableView.addGestureRecognizer(longPress)
        classModel.loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func LongPress(gestureRecongnizer:UILongPressGestureRecognizer) {
        if gestureRecongnizer.state == UIGestureRecognizerState.began {
            
        }
        if gestureRecongnizer.state == UIGestureRecognizerState.ended {
            if self.tableView.isEditing == false {
                self.tableView.setEditing(true, animated: true)
            }
            else{
                self.tableView.setEditing(false, animated: true)
            }
        }
    }

    @IBAction func addclass(_ sender: AnyObject) {
        let alert = UIAlertController(title: "添加类别", message: "请输入类别名", preferredStyle: .alert)
        alert.addTextField {
            (UITextField) in
            UITextField.becomeFirstResponder()
            UITextField.returnKeyType = .done
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
            if alert.textFields?.first?.text != "" {
                self.classModel.ClassList.append(ClassInfo(listclass: (alert.textFields?.first?.text)!))
                self.classModel.saveData()
                self.tableView.reloadData()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "classchange"), object: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
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
        // #warning Incomplete implementation, return the number of rows
        return classModel.ClassList.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedClass = classModel.ClassList[indexPath.row].listclass
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassesList", for: indexPath) as! ClassCell
        let classes = classModel.ClassList[indexPath.row] as ClassInfo
        cell.listclass.text = classes.listclass
        
        if cell.listclass.text == selectedClass {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedclass" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let classaaaa: String = (classModel.ClassList[(indexPath?.row)!] as ClassInfo).listclass
            if !detail {
                let Controller = segue.destination as! AddController
                Controller.selectedclass = classaaaa
            }
            else {
                let Controller = segue.destination as! DetailController
                Controller.selectedclass = classaaaa
                detail = false
            }
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            financeModel.loadData()
            var b: Bool = false
            for a in financeModel.FinanceList {
                if a.listclass == tableView.cellForRow(at: indexPath)?.textLabel?.text {
                    b = true
                    break
                }
            }
            if !b && tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
                classModel.ClassList.remove(at: indexPath.row)
                classModel.saveData()
                self.tableView.reloadData()
                self.tableView.setEditing(true, animated: true)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "classchange"), object: nil)
            }
            else {
                let alert = UIAlertController(title: "警告", message: "该类别已被选中，无法删除", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            self.tableView.setEditing(true, animated: true)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let content = classModel.ClassList[sourceIndexPath.row]
        classModel.ClassList.remove(at: sourceIndexPath.row)
        classModel.ClassList.insert(content, at: destinationIndexPath.row)
        classModel.saveData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "classchange"), object: nil)
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
