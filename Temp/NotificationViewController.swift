//
//  NotificationViewController.swift
//  Demo
//
//  Created by Fujinet on 3/28/18.
//  Copyright © 2018 Fujinet. All rights reserved.
//
// Noti : import UserNotifications, UNUserNotificationCenterDelegate
import UIKit
import UserNotifications
class NotificationViewController: UIViewController, UNUserNotificationCenterDelegate {
    // region init
    @IBOutlet weak var txtNotiInfo: UITextView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtContent: UITextField!
    @IBOutlet weak var txtUrl: UITextField!
    
    // end region init
    override func viewDidLoad() {
        super.viewDidLoad()
        // permission noti
        initNotificationSetupCheck()
        // handing noti
        UNUserNotificationCenter.current().delegate = self
        // end
        self.txtNotiInfo.layer.borderWidth = 2
        self.txtNotiInfo.layer.borderColor = UIColor.black.cgColor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // event post notification
    @IBAction func btnLocalNoti(_ sender: Any) {
        // START PUSH
        let title = txtTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let content = txtContent.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let url = txtUrl.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        if(title == "" || content == "" || url == "") {
            let alert = UIAlertController(title: "Fujinet", message: "Please enter full information", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            pushLocal()
            setTextNull()
        }
    }
    // Set null
    func setTextNull() {
        txtTitle.text = ""
        txtContent.text = ""
        txtUrl.text = ""
    }
    // Push local
    func pushLocal() {
        let content = UNMutableNotificationContent()
        content.title = txtTitle.text!
        content.subtitle = txtContent.text!
        content.body = txtUrl.text!
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "NotiLocalIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    // Hadling noti
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "NotiLocalIdentifier" {
            print(response.notification.request.content.title)
            let title = response.notification.request.content.title
            let subtitle = response.notification.request.content.subtitle
            let body = response.notification.request.content.body
            print(title + subtitle + body)
            txtNotiInfo.text = "Title: " + title + "\n" + "Content: " + subtitle + "\n" + "Url: " + body
        }
        completionHandler()
    }
    // Check permission
    func initNotificationSetupCheck() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
        { (success, error) in
            if success {
                print("Permission Granted")
            } else {
                print("There was a problem!")
            }
        }
    }
    //end
    
    // end event post notification
    // event back
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
