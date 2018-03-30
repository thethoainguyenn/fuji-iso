//
//  StoredDataViewController.swift
//  Demo
//
//  Created by Fujinet on 3/28/18.
//  Copyright © 2018 Fujinet. All rights reserved.
//

import UIKit

class StoredDataViewController: UIViewController {
    // region init
    @IBOutlet weak var txtBirthDay: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var sliderHealth: UISlider!
    @IBOutlet weak var sgmIsMessage: UISegmentedControl!
    
    @IBOutlet weak var imgRadioMale: UIImageView!
    @IBOutlet weak var imgRadioFemale: UIImageView!
    
    @IBOutlet weak var imgCbCoder: UIImageView!
    @IBOutlet weak var imgCbSport: UIImageView!
    
    // end region init
    var isSex = true // true: male - false: female
    var isCoder = false
    var isSport = false
    // Core data - Users: name table
    var users:[Users]? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // action seleted radio Male
        let tapRadioMale = UITapGestureRecognizer(target: self, action: #selector(imageCheckedMale(tapRadioMale:)))
        imgRadioMale.isUserInteractionEnabled = true
        imgRadioMale.addGestureRecognizer(tapRadioMale)
        // end action seledted radio Male
        
        // default
        imgRadioMale.image = UIImage(named: "radio_checked")
        
        // action selected Female
        let tapRadioFemale = UITapGestureRecognizer(target: self, action: #selector(imageCheckedFemale(tapRadioFemale:)))
        imgRadioFemale.isUserInteractionEnabled = true
        imgRadioFemale.addGestureRecognizer(tapRadioFemale)
        // end action seleted radio Male
        
        // action checkbox coder
        let tapCbCoder = UITapGestureRecognizer(target: self, action: #selector(imageCheckedCoder(tapCbCoder:)))
        imgCbCoder.isUserInteractionEnabled = true
        imgCbCoder.addGestureRecognizer(tapCbCoder)
        // action checkbox sport
        let tapCbSport = UITapGestureRecognizer(target: self, action: #selector(imageCheckedSport(tapCbSport:)))
        imgCbSport.isUserInteractionEnabled = true
        imgCbSport.addGestureRecognizer(tapCbSport)
    }
    // event back to Demolist
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // validation
    func checkValidation() -> Bool{
         let username = txtUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines)
         let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
         let phoneNumber = txtPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
         let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
         let birthDay = txtBirthDay.text?.trimmingCharacters(in: .whitespacesAndNewlines)
         if(username == "" || password == "" || phoneNumber == "" || email == "" || birthDay == "") {
            return true
         }
         return false
    }
    //end validation
    
    // get information
    func getInformation() -> String {
                let username = txtUsername.text
                let password = txtPassword.text
                let phoneNumber = txtPhoneNumber.text
                let email = txtEmail.text
                let birthDay = txtBirthDay.text
                let sex = isSex ? "Nam" : "Nữ"
                var hobby = "NULL"
                if(!isCoder && !isSport) {
        
                } else {
                    if(isCoder && isSport) {
                        hobby = "Lập trình&Thể thao"
                    } else {
                        if(isCoder && !isSport) {
                            hobby = "Lập trình"
                        } else {
                            hobby = "Thể thao"
                        }
                    }
                }
                var health = "Tốt"
                if(sliderHealth.value >= 0.7 && sliderHealth.value <= 1) {
                    
                } else {
                        if(sliderHealth.value >= 0.5 && sliderHealth.value < 0.7) {
                                health = "Bình thường"
                    } else {
                            health = "Kém"
                    }
                }
                let isMessage = sgmIsMessage.selectedSegmentIndex == 0 ? "Có" : "Không"
        
        let info = "Username: " + username! + "\n" + "Password: " + password! + "\n" + "Phone Number: " + phoneNumber! + "\n" + "Email: " + email! + "\n" + "Giới tính:" + sex + "\n" + "Ngày sinh: " + birthDay! + "\n" + "Sở thích: " + hobby + "\n" + "Sức khoẻ: " + health + "\n" + "Nhận tin mới: " + isMessage
        return info
    }
    // end get infomation
    
    // event submit
    @IBAction func btnSubmit(_ sender: Any) {
        // Show alert infomation
        let alert = UIAlertController(title: "Information User", message: getInformation(), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // SAVE DATA - FUNTION WRITE FILE AND WRITE DB - True: Write DB , false: Write file
    func writeData(isSave: Bool) {
        if(checkValidation()) {
            let alert = UIAlertController(title: "Fujinet", message: "Please enter full information", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let username = txtUsername.text
            let password = txtPassword.text
            let phoneNumber = txtPhoneNumber.text
            let email = txtEmail.text
            let birthDay = txtBirthDay.text
            let sex = isSex ? "Nam" : "Nữ"
            var hobby = "NULL"
            if(!isCoder && !isSport) {
                
            } else {
                if(isCoder && isSport) {
                    hobby = "Lập trình&Thể thao"
                } else {
                    if(isCoder && !isSport) {
                        hobby = "Lập trình"
                    } else {
                        hobby = "Thể thao"
                    }
                }
            }
            let health = String(sliderHealth.value)
            let isMessage = sgmIsMessage.selectedSegmentIndex == 0 ? "Có" : "Không"
            if(isSave) {
                print("Chay vo write data")
                // WRITE DB
                users = CoreDataHandler.fetchObject()
                let id = (users?.count)! + 1
                CoreDataHandler.saveObject(id_user: Int32(id), username: username!, password: password!, phone_number: phoneNumber!, email: email!, sex: sex, birth_day: birthDay!, hobby: hobby, health: health, is_message: isMessage)
                showAlert(mgs: "Write DB Success")
                
            } else {
                // WRITE FILE
                let data = username! + "|" + password! + "|" + phoneNumber! + "|" + email! + "|" + sex + "|" + birthDay! + "|" + hobby + "|" + health + "|" + isMessage
                writeFile(data: data)
                showAlert(mgs: "Write file Success")
            }
        }
    }
    // Show alert
    func showAlert(mgs: String) {
        let alert = UIAlertController(title: "FUJINET", message: mgs, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // END SAVE DAT
    // event write file
    @IBAction func btnWriteFile(_ sender: Any) {
        writeData(isSave: false)
    }
    func writeFile(data: String) {
        let file = "file.txt"
        //let text = String(describing: user)
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            //writing
            do {
                try data.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
    }
    // end event write file
    
    // event read file
    func readFile() -> Array<Any> {
        let file = "file.txt"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            //reading
            do {
                let result = try String(contentsOf: fileURL, encoding: .utf8)
                return result.components(separatedBy: "|")
            }
            catch { }
        }
        return []
    }
    
    // write DB - Using core data
    @IBAction func btnWriteDB(_ sender: Any) {
        writeData(isSave: true)
    }
    // end write DB
    
    // event read DB
    @IBAction func btnReadDB(_ sender: Any) {
       let data = readDB()
       setData(data: data)
    }
    func readDB() -> Array<Any> {
        users = CoreDataHandler.fetchObject()
        let arrCount = (users?.count)!
        
        print(arrCount)
        for items in users! {
            if(items.id_user == arrCount - 1) {
               let data = items.username! + "|" + items.password! + "|" + items.phone_number! + "|" + items.email! + "|" + items.sex! + "|" + items.birth_day! + "|" + items.hobby! + "|" + items.health! + "|" + items.is_message!
                return data.components(separatedBy: "|")
            }
        }
        return []
    }
    
    
    // end read DB
    @IBAction func btnReadFile(_ sender: Any) {
        let data = readFile()
        setData(data: data)
    }
    // set data view control after read db or read file
    func setData(data: Array<Any>) {
        txtUsername.text = String(describing: data[0])
        txtPassword.text = String(describing: data[1])
        txtPhoneNumber.text = String(describing: data[2])
        txtEmail.text = String(describing: data[3])
        // check sex
        if (String(describing: data[4]) == "Nam" ) {
            imgRadioMale.image = UIImage(named: "radio_checked")
            imgRadioFemale.image = UIImage(named: "radio")
            isSex = true
        } else {
            imgRadioFemale.image = UIImage(named: "radio_checked")
            imgRadioMale.image = UIImage(named: "radio")
            isSex = false
        }
        // end check sex
        
        txtBirthDay.text = String(describing: data[5])
        
        // check hobby
        if(String(describing: data[6]) == "NULL") {
            
        } else {
            if(String(describing: data[6]) == "Lập trình&Thể thao") {
                imgCbCoder.image = UIImage(named: "checkbox_checked")
                isCoder = true
                imgCbSport.image = UIImage(named: "checkbox_checked")
                isSport = true
            } else {
                if(String(describing: data[6]) == "Lập trình") {
                    imgCbCoder.image = UIImage(named: "checkbox_checked")
                    isCoder = true
                } else {
                    imgCbSport.image = UIImage(named: "checkbox_checked")
                    isSport = true
                }
            }
        }
        // end check hobby
        sliderHealth.value = Float(String(describing: data[7]))!
        let statusMessage = String(describing: data[8]) == "Có" ? 0 : 1
        sgmIsMessage.selectedSegmentIndex = statusMessage
    }
    
    // end event read file
    
    @objc func imageCheckedCoder(tapCbCoder: UITapGestureRecognizer)
    {
        _ = tapCbCoder.view as! UIImageView
        // set img checked
        if(isCoder == false) {
            imgCbCoder.image = UIImage(named: "checkbox_checked")
            isCoder = true
        } else {
            imgCbCoder.image = UIImage(named: "checkbox")
            isCoder = false
        }
    }
    @objc func imageCheckedSport(tapCbSport: UITapGestureRecognizer)
    {
        _ = tapCbSport.view as! UIImageView
        // set img checked
        if(isSport == false) {
            imgCbSport.image = UIImage(named: "checkbox_checked")
            isSport = true
        } else {
            imgCbSport.image = UIImage(named: "checkbox")
            isSport = false
        }
    }
    @objc func imageCheckedMale(tapRadioMale: UITapGestureRecognizer)
    {
        _ = tapRadioMale.view as! UIImageView
        // set img checked
        imgRadioMale.image = UIImage(named: "radio_checked")
        imgRadioFemale.image = UIImage(named: "radio")
        isSex = true
    }
    @objc func imageCheckedFemale(tapRadioFemale: UITapGestureRecognizer)
    {
        _ = tapRadioFemale.view as! UIImageView
        // set img checked
        imgRadioFemale.image = UIImage(named: "radio_checked")
        imgRadioMale.image = UIImage(named: "radio")
        isSex = false
    }
    
    // birth day - envent begin show date time
    @IBAction func txtBirth_day(_ sender: Any) {
        let datePicker = UIDatePicker()
        txtBirthDay.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
    }
    @objc func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        txtBirthDay.text = formatter.string(from: sender.date)
        
        print("Try this at home")
    }
    // end set birth day

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
// create class user
class User {
    var id_user: Int32
    var username: String
    var password: String
    var phoneNumber: String
    var email: String
    var sex: String
    var birthDay: String
    var hobby: String
    var health: String
    var isMessage: String
    init(id_user: Int32,username: String, password: String, phoneNumber: String, email: String, sex: String, birthDay: String, hobby: String, health: String, isMessage: String ) {
        self.id_user = id_user
        self.username = username
        self.password = password
        self.phoneNumber = phoneNumber
        self.email = email
        self.sex = sex
        self.birthDay = birthDay
        self.hobby = hobby
        self.health = health
        self.isMessage = isMessage
    }

}

