//
//  DemoListViewController.swift
//  Demo
//
//  Created by Fujinet on 3/27/18.
//  Copyright © 2018 Fujinet. All rights reserved.
//

import UIKit

class DemoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var username: String!
    // init
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
    @IBOutlet weak var tblViewMenu: UITableView!
    var arrMenu = [String]()
    // end init
    // create array menu
    let VIEW_CONTROL: String = "View Control/Stored Data"
    let CLIPBOARD: String = "Clipboard"
    let REQUEST: String = "Request/Response"
    let NOTIFICATION: String = "Notification"
    let LIST_TABLE: String = "List/Tabel"
    // end create array menu
    override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.lblUsername.text = username
        self.lblDateTime.text = getDate()
        arrMenu.append(VIEW_CONTROL)
        arrMenu.append(CLIPBOARD)
        arrMenu.append(REQUEST)
        arrMenu.append(NOTIFICATION)
        arrMenu.append(LIST_TABLE)
        tblViewMenu.dataSource = self
        tblViewMenu.delegate = self
        // custom table view
        tblViewMenu.layer.borderColor = UIColor.black.cgColor
        tblViewMenu.layer.borderWidth = 1.0
        // end custom table view
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // region tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = arrMenu[indexPath.row]
        return cell!
    }
    // end region table view
    //event click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = arrMenu[indexPath.row]
        switch result {
        case VIEW_CONTROL:
            let goToStoredData: StoredDataViewController = storyboard?.instantiateViewController(withIdentifier: "storedDataViewController") as! StoredDataViewController
            self.navigationController?.pushViewController(goToStoredData, animated: true)
            break
        case CLIPBOARD:
            let goToClipboard: ClipboardViewController = storyboard?.instantiateViewController(withIdentifier: "clipboardViewController") as! ClipboardViewController
            self.navigationController?.pushViewController(goToClipboard, animated: true)
            break
        case REQUEST:
            let goToRequest: RequestViewController = storyboard?.instantiateViewController(withIdentifier: "requestViewController") as! RequestViewController
            self.navigationController?.pushViewController(goToRequest, animated: true)
            break
        case NOTIFICATION:
            let goToNotification: NotificationViewController = storyboard?.instantiateViewController(withIdentifier: "notificationViewController") as! NotificationViewController
            self.navigationController?.pushViewController(goToNotification, animated: true)
            break
        case LIST_TABLE:
            let goToListTable: ListTableViewController = storyboard?.instantiateViewController(withIdentifier: "listTableViewController") as! ListTableViewController
            self.navigationController?.pushViewController(goToListTable, animated: true)
            break
        default:
            break
        }
    }
    // event logout
    @IBAction func btnLogout(_ sender: Any) {
        // remove local data
        let defaults = UserDefaults.standard
        //defaults.set(txtUsername.text, forKey: "STATUS_LOGIN")
        defaults.removeObject(forKey: "STATUS_LOGIN")
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // get date time
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        //let result = formatter.string(from: date)
        return formatter.string(from: date)
        }
    // end get date time
}
