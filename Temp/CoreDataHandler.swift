//
//  CoreDataHandler.swift
//  Demo
//
//  Created by Fujinet on 3/30/18.
//  Copyright © 2018 Fujinet. All rights reserved.
//

import UIKit
import CoreData
class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(id_user: Int32, username: String, password: String, phone_number: String, email: String, sex: String, birth_day: String, hobby:String, health: String, is_message: String ) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        manageObject.setValue(id_user, forKey: "id_user")
        manageObject.setValue(username, forKey: "username")
        manageObject.setValue(password, forKey: "password")
        manageObject.setValue(phone_number, forKey: "phone_number")
        manageObject.setValue(email, forKey: "email")
        manageObject.setValue(sex, forKey: "sex")
        manageObject.setValue(birth_day, forKey: "birth_day")
        manageObject.setValue(hobby, forKey: "hobby")
        manageObject.setValue(health, forKey: "health")
        manageObject.setValue(is_message, forKey: "is_message")
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    class func fetchObject() -> [Users]? {
        let context = getContext()
        var users:[Users]? = nil
        
        do{
            users = try context.fetch(Users.fetchRequest())
            return users
        }catch {
            return users
        }
        
    }
}
