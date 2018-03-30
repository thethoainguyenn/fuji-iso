//
//  ListTableViewController.swift
//  Demo
//
//  Created by Fujinet on 3/30/18.
//  Copyright © 2018 Fujinet. All rights reserved.
//

import UIKit

class ListTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // event back
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
