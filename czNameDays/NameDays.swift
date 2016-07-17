//
//  NameDays.swift
//  czNameDays
//
//  Created by Petr Řezníček on 07.12.15.
//  Copyright © 2015 Petr Řezníček. All rights reserved.
//

import Foundation

class NameDays {

    func getNameDay(offset: Int = 0, long: Bool = false) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let interval = Double(offset)*24*60*60
        let code = dateFormatter.stringFromDate(NSDate(timeIntervalSinceNow: interval))
        let country = getCountry()
        let nameDay = NamesList(code)
        
        if (nameDay[country]??.count > 0) {
            if (nameDay[country]??.count > 1) {
                return nameDay[country]!![1] as! String
            }
            else {
                return nameDay[country]!![0] as! String
            }
        }
        else {
            return NSLocalizedString("N/A", comment: "Unsupported country")
        }
    }
    
    func getNameDayByDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let code = dateFormatter.stringFromDate(date)
        let nameDay = NamesList(code)
        if (nameDay[getCountry()]??.count > 0) {
            return nameDay[getCountry()]!![0] as! String
        }
        else {
            return NSLocalizedString("N/A", comment: "Unsupported country")
        }
    }
    
    func getCountry() -> String {
        return NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
    }
    
    private func NamesList(date: String) -> AnyObject {
        let path = NSBundle.mainBundle().pathForResource("NameDays", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)!
        return dict.objectForKey(date)!
    }
}