import UIKit

class FirstViewController: TabVCTemplate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UISearchBarDelegate {

    @IBOutlet weak var viewtitle: UINavigationItem!
    @IBOutlet weak var choose: UISegmentedControl!
    @IBOutlet weak var tableaa: UITableView!
    @IBOutlet weak var searchtext: UISearchBar!
    @IBOutlet weak var allmoney: UILabel!
    let financeModel = FinanceModel()
    var 收入: [FinanceInfo] = []
    var 支出: [FinanceInfo] = []
    var 占时1: [FinanceInfo] = []
    var 占时2: [FinanceInfo] = []
    var chooseclass: String? = nil
    var startdate: Date? = nil
    var enddate: Date? = nil
    var 收入all: Int = 0
    var 支出all: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(LongPress))
        longPress.delegate = self
        longPress.minimumPressDuration = 0.5
        tableaa.addGestureRecognizer(longPress)
        tableaa.delegate = self
        tableaa.dataSource = self
        searchtext.delegate = self
        加载(content: searchtext.text!)
        viewtitle.title = choose.titleForSegment(at: 0)
        choose.selectedSegmentIndex == 0 ? (allmoney.textColor = UIColor.blue) : (allmoney.textColor = UIColor.red)
        choose.selectedSegmentIndex == 0 ? (allmoney.text = String(收入all)) : (allmoney.text = String(支出all))
        let headers = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(header))
        headers?.lastUpdatedTimeLabel.isHidden = true
        tableaa.mj_header = headers
    }
    
    override func viewWillAppear(_ animated: Bool) {
        加载(content: searchtext.text!)
        tableaa.reloadData()
    }
    
    func header() {
        tableaa.reloadData()
        tableaa.setEditing(false, animated: true)
        tableaa.mj_header.endRefreshing()
        ProgressHUD.showSuccess("666")
    }
    
    
    func 加载(content: String) {
        let t = DateFormatter()
        t.dateStyle = .short
        t.timeStyle = .short
        financeModel.loadData()
        收入 = []
        支出 = []
        占时1 = []
        for a in financeModel.FinanceList {
            if content != "" {
//                var d: Int = 0
//                for c in a.content.characters {
//                    for b in content.characters {
//                        print(String(b))
//                        if String(c).lowercased() == String(b).lowercased() {
//                            d += 1
//                        }
//                    }
//                }
                if a.content.lowercased().contains(content.lowercased()) {
                    占时1.append(a)
                }
            }
            else {
                占时1.append(a)
            }
        }
        占时2 = []
        for a in 占时1 {
            let date = t.date(from: a.date)
            if startdate != nil && enddate != nil {
                if startdate! < date! && date! < enddate! {
                    占时2.append(a)
                }
            }
            else if startdate != nil || enddate != nil {
                if startdate != nil && startdate! < date! {
                    占时2.append(a)
                }
                else if enddate != nil && enddate! > date! {
                    占时2.append(a)
                }
            }
            else {
                占时2.append(a)
            }
        }
        占时1 = []
        for a in 占时2 {
            if chooseclass != nil {
                if a.listclass == chooseclass {
                    占时1.append(a)
                }
            }
            else {
                占时1.append(a)
            }
        }
        for a in 占时1 {
            if a.situation == "收入" {
                收入.append(a)
            }
            else if a.situation == "支出" {
                支出.append(a)
            }
        }
        收入all = 0
        支出all = 0
        for a in 收入 {
            收入all += Int(a.money)!
        }
        for a in 支出 {
            支出all += Int(a.money)!
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchtext.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        加载(content: searchText)
        tableaa.reloadData()
    }
    
    @IBAction func toggleMenu(_ sender: AnyObject) {
        searchtext.resignFirstResponder()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    @IBAction func cancelViewController(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(segue:UIStoryboardSegue) {
        let control = segue.source as! AddController
        let alert = UIAlertController(title: "提示", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        if control.number.text == "" {
            alert.message = "请输入金额"
            self.present(alert, animated: true, completion: nil)
        }
        else if control.Detail.text == "" {
            alert.message = "请选择类别"
            self.present(alert, animated: true, completion: nil)
        }
        else if control.text.text == "" {
            alert.message = "请输入内容"
            self.present(alert, animated: true, completion: nil)
        }
        else {
            financeModel.loadData()
            let add = FinanceInfo(content: control.text.text!, date: control.date.text!, money: control.number.text!, listclass: control.Detail.text!, situation: control.状态)
            financeModel.FinanceList.append(add)
            financeModel.saveData()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func LongPress(gestureRecongnizer:UILongPressGestureRecognizer) {
        if gestureRecongnizer.state == UIGestureRecognizerState.began {
            
        }
        if gestureRecongnizer.state == UIGestureRecognizerState.ended {
            if tableaa.isEditing == false {
                tableaa.setEditing(true, animated: true)
            }
            else{
                tableaa.setEditing(false, animated: true)
            }
        }
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            searchtext.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }
    
    @IBAction func chooseaction(_ sender: AnyObject) {
        if choose.selectedSegmentIndex == 0 {
            viewtitle.title = "收入"
            tableaa.reloadData()
            allmoney.textColor = UIColor.blue
            allmoney.text = String(收入all)
        }
        else {
            viewtitle.title = "支出"
            tableaa.reloadData()
            allmoney.textColor = UIColor.red
            allmoney.text = String(支出all)
        }
    }
    
    @IBAction func search(segue:UIStoryboardSegue) {
        let Controller = segue.source as! LeftMenu
        chooseclass = Controller.classa
        startdate = Controller.start
        enddate = Controller.end
        加载(content: searchtext.text!)
        tableaa.reloadData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    @IBAction func cleanall(segue:UIStoryboardSegue) {
        chooseclass = nil
        startdate = nil
        enddate = nil
        加载(content: searchtext.text!)
        tableaa.reloadData()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let control = segue.destination as! AddController
            print(choose.titleForSegment(at: choose.selectedSegmentIndex)!)
            control.状态 = choose.titleForSegment(at: choose.selectedSegmentIndex)!
        }
        if segue.identifier == "Detail" {
            if let indexPath = self.tableaa.indexPathForSelectedRow{
                let a: FinanceInfo
                if choose.selectedSegmentIndex == 0 {
                    a = 收入[indexPath.row]
                }
                else {
                    a = 支出[indexPath.row]
                }
                let detail = segue.destination as! DetailController
                detail.numberrow = financeModel.FinanceList.index(of: a)!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if choose.selectedSegmentIndex == 0 {
            return 收入.count
        }
        else{
            return 支出.count
        }
//        return financeModel.FinanceList.count
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Financelist", for: indexPath) as! ListCell
        if choose.selectedSegmentIndex == 0 {
            if 收入 != [] {
                cell.content.text = 收入[indexPath.row].content
                cell.date.text = 收入[indexPath.row].date
                cell.listclass.text = 收入[indexPath.row].listclass
                cell.money.text = 收入[indexPath.row].money
            }
            cell.money.textColor = UIColor.blue
        }
        else {
            if 支出 != [] {
                cell.content.text = 支出[indexPath.row].content
                cell.date.text = 支出[indexPath.row].date
                cell.listclass.text = 支出[indexPath.row].listclass
                cell.money.text = 支出[indexPath.row].money
            }
            cell.money.textColor = UIColor.red
        }
//        cell.content.text = financeModel.FinanceList[indexPath.row].content
//        cell.date.text = financeModel.FinanceList[indexPath.row].date
//        cell.listclass.text = financeModel.FinanceList[indexPath.row].listclass
//        cell.money.text = financeModel.FinanceList[indexPath.row].money
        return cell
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let mdzz: FinanceInfo!
            if choose.selectedSegmentIndex == 0 {
                mdzz = 收入[indexPath.row]
            }
            else {
                mdzz = 支出[indexPath.row]
            }
            let a = financeModel.FinanceList.index(of: mdzz)
            financeModel.FinanceList.remove(at: a!)
            financeModel.saveData()
            if 收入.count == 0 || 支出.count == 0 {
                tableaa.setEditing(false, animated: true)
            }
            加载(content: "")
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

