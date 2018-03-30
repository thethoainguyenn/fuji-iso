//
//  ClipboardViewController.swift
//  Demo
//
//  Created by Fujinet on 3/28/18.
//  Copyright © 2018 Fujinet. All rights reserved.
//

import UIKit

class ClipboardViewController: UIViewController {
    // region init
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var txtOutput: UITextField!
    
    // end region init
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // Event back
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    // Funtion alert
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Fujinet", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
    // Event coppy to clipboard
    @IBAction func btnCopy(_ sender: Any) {
        if(txtInput.text == "") {
           showAlert(msg: "Please enter characters")
        } else {
             UIPasteboard.general.string = txtInput.text
            }
    }
    // Event read from clipboard
    @IBAction func btnOutput(_ sender: Any) {
        if let myString = UIPasteboard.general.string {
            txtOutput.insertText(myString)
        }
        else {
            showAlert(msg: "Please coppy to clipboard")
            }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
