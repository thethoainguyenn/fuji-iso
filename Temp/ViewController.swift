//
//  ViewController.swift
//  Demo
//
//  Created by Fujinet on 3/27/18.
//  Copyright © 2018 Fujinet. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        underLineLanguage(btn: btnEnglish, textName: "English")
        
        // check status login and language
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "STATUS_LOGIN") != nil {
           goToMain()
        } else {
            if defaults.string(forKey: "STATUS_LANGUAGE_CHANGE") != nil {
                UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                self.setLanguageCurrent()
                // Button text
                self.underLineLanguage(btn: self.btnEnglish, textName: "English")
                self.textDefaultLanguage(btn: self.btnVietnames, textName: "Tiếng Việt")
                
            } else {
                UserDefaults.standard.set(["vi"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                self.setLanguageCurrent()
                // Button text
                self.underLineLanguage(btn: self.btnVietnames, textName: "Tiếng Việt")
                self.textDefaultLanguage(btn: self.btnEnglish, textName: "English")
            }
        }
        }
        // end check status login and language
        

    // set language current
    func setLanguageCurrent() {
        self.lblUsername.text = NSLocalizedString("username", comment: "username english")
        self.lblPassword.text = NSLocalizedString("password", comment: "password english")
        self.lblTitle.text = NSLocalizedString("txt_login", comment: "title login english")
        self.btnTextLogin.setTitle(NSLocalizedString("btn_login", comment: "Text of button login"), for: UIControlState.normal)
        }
    // end set language current
    
    // region init
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnVietnames: UIButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnTextLogin: UIButton!
    // end region init
    // underline button
    func underLineLanguage(btn: UIButton, textName: String) {
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor : UIColor.blue,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        let attributeString = NSMutableAttributedString(string: textName,
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
    }
    func textDefaultLanguage(btn: UIButton, textName: String) {
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor : UIColor.black]
        let attributeString = NSMutableAttributedString(string: textName,
                                                        attributes: yourAttributes)
        btn.setAttributedTitle(attributeString, for: .normal)
    }
    // end underline button
    // action change language
    @IBAction func btnEnglishChange(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set("en", forKey: "STATUS_LANGUAGE_CHANGE")
//        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        self.setLanguageCurrent()
        viewDidLoad()
    }
    @IBAction func btnVietnamesChange(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "STATUS_LANGUAGE_CHANGE")
//        UserDefaults.standard.set(["vi"], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        self.setLanguageCurrent()
        viewDidLoad()
    }
    
    // end action change
    @IBAction func btnLogin(_ sender: Any) {
        if (txtUsername.text == "admin" && txtPassword.text == "admin") {
            goToMain()
            // save local data
            let defaults = UserDefaults.standard
            defaults.set(txtUsername.text, forKey: "STATUS_LOGIN")
            
        } else {
            if(txtUsername.text == "" || txtPassword.text == "") {
                // create the alert
                let alert = UIAlertController(title: "Fujinet", message: "Please enter full information", preferredStyle: UIAlertControllerStyle.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Fujinet", message: "Wrong login information. Please check again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    func goToMain() {
        let demoList = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "demoListViewController") as? DemoListViewController
        navigationController?.pushViewController(demoList!, animated: true)
        demoList?.username = txtUsername.text
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

