//
//  ViewController.swift
//  czNameDays
//
//  Created by Petr Řezníček on 07.12.15.
//  Copyright © 2015 Petr Řezníček. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var tomorrow: UILabel!
    @IBOutlet weak var aftertomorrow: UILabel!
    @IBOutlet weak var today_date: UILabel!
    @IBOutlet weak var tomorrow_date: UILabel!
    @IBOutlet weak var aftertomorrow_date: UILabel!
    
    let ND = NameDays()
    
    override func viewDidLoad() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "(EEEE dd. MMMM)"
        self.today_date.text = dateFormatter.stringFromDate(NSDate())
        self.tomorrow_date.text = dateFormatter.stringFromDate(NSDate(timeIntervalSinceNow: 1*24*60*60))
        self.aftertomorrow_date.text = dateFormatter.stringFromDate(NSDate(timeIntervalSinceNow: 2*24*60*60))
        
        self.today.text = ND.getNameDay(long: true)
        self.tomorrow.text = ND.getNameDay(1, long: true)
        self.aftertomorrow.text = ND.getNameDay(2, long: true)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

