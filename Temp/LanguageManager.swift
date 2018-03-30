//
//  LanguageManager.swift
//  SMSLocalization
//
//  Created by Macuser on 5/19/16.
//  Copyright © 2016 Macuser. All rights reserved.
//

import UIKit

class LanguageManager: NSObject {
    
    var availableLocales = [Locale]()
    static let sharedInstance = LanguageManager()
    
    override init() {
        
        let english = Locale()
        english.initWithLanguageCode(languageCode: "en", countryCode: "gb", name: "United Kingdom")
        
        let finnish  = Locale()
        finnish.initWithLanguageCode(languageCode: "vi", countryCode: "vi", name: "VietNamese")
        self.availableLocales = [english,finnish]
        
    }
    
    func getCurrentBundle()->Bundle{
        
        let bundlePath = Bundle.mainBundle.pathForResource(getSelectedLocale(), ofType: "lproj")
        let bundle = Bundle(path: bundlePath!)
        return bundle!
        
    }
    
    private func getSelectedLocale()->String{
        
        let lang = NSLocale.preferredLanguages
        let languageComponents: [String : String] = NSLocale.components(fromLocaleIdentifier: lang[0])
        
        if let languageCode: String = languageComponents[NSLocaleLanguageCode]{
            
            for locale in availableLocales {
                if(locale.languageCode == languageCode){
                    
                    return locale.languageCode!
                }
            }
        }
        return "en"
    }
    
    func setLocale(langCode:String){
        
        UserDefaults.standardUserDefaults().setObject([langCode], forKey: "AppleLanguages")
        UserDefaults.standardUserDefaults().synchronize()
        
    }
}
class Locale: NSObject {
    var name:String?
    var languageCode:String?
    var countryCode:String?
    
    func initWithLanguageCode(languageCode: String,countryCode:String,name: String)->AnyObject{
        self.name = name
        self.languageCode = languageCode
        self.countryCode = countryCode
        return self
    }
}
