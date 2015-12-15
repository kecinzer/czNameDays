//
//  InterfaceController.swift
//  czNameDays WatchKit Extension
//
//  Created by Petr Řezníček on 07.12.15.
//  Copyright © 2015 Petr Řezníček. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    @IBOutlet var today: WKInterfaceLabel!
    @IBOutlet var tomorrow: WKInterfaceLabel!
    @IBOutlet var aftertomorrow: WKInterfaceLabel!
    
    let ND = NameDays()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EE dd. MM."
        super.setTitle(dateFormatter.stringFromDate(NSDate()))
        self.today.setText(ND.getNameDay(long: true))
        self.tomorrow.setText(ND.getNameDay(1, long: true))
        self.aftertomorrow.setText(ND.getNameDay(2, long: true))
        // I need to extend complication
        ComplicationController.extendComplications()
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
