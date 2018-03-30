//
//  RequestViewController.swift
//  Demo
//
//  Created by Fujinet on 3/28/18.
//  Copyright © 2018 Fujinet. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {
    // region init
    @IBOutlet weak var txtUrl: UITextView!
    @IBOutlet weak var txtResult: UITextView!
    // end region init
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorderTextView()
        self.txtUrl.text = "GET API WEATHER CURRENT LONDON CITY \n HHTP GET: \n http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
    }
    // event back
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    // event get api http get
    @IBAction func btnRequest(_ sender: Any) {
        getApi()
    }
    func getApi() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22")!
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        print(json)
                        // Name city
                        let nameCity = json["name"] as! String
                        // Temp
                        let main = json["main"] as! [String: Any]
                        let temp = main["temp"] as! NSNumber
                        // Description, type array
                        let weather = json["weather"] as! [[String: AnyObject]]
                        for item in weather {
                            let description = item["description"] as! String
                            DispatchQueue.main.async {
                                self.txtResult.text = "City: " + nameCity + "\n" + "Temp: " + String(describing: temp) + "\n" + "Description: " + description
                            }
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
            
        })
        task.resume()
    }
    
    
    func setBorderTextView() {
        self.txtUrl.layer.borderWidth = 2
        self.txtUrl.layer.borderColor = UIColor.black.cgColor
        self.txtResult.layer.borderWidth = 2
        self.txtResult.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
