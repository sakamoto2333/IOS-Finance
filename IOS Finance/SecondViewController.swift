import UIKit

class SecondViewController: TabVCTemplate {

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedTab = 1
        // do stuff here
    }
    
    @IBAction func toggleMenu(_ sender: AnyObject) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "toggleMenu"), object: nil)
    }

}

