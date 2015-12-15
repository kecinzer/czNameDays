//
//  ComplicationController.swift
//  czNameDays WatchKit Extension
//
//  Created by Petr Řezníček on 07.12.15.
//  Copyright © 2015 Petr Řezníček. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {

    let ND = NameDays()
    
    func timelineEntryForDate(date: NSDate) -> CLKComplicationTimelineEntry {
        let template = CLKComplicationTemplateUtilitarianSmallFlat()
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        template.textProvider = CLKSimpleTextProvider(text: ND.getNameDayByDate(date))

        return CLKComplicationTimelineEntry(date: cal.startOfDayForDate(date), complicationTemplate: template)
    }
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let startDate: NSDate = cal.startOfDayForDate(NSDate(timeIntervalSinceNow: -1*24*60*60))
        handler(startDate)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let endDate: NSDate = cal.startOfDayForDate(NSDate(timeIntervalSinceNow: 2*24*60*60)).dateByAddingTimeInterval(-1)
        handler(endDate)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Call the handler with the current timeline entry
        switch complication.family {
        case .UtilitarianSmall:
            handler(timelineEntryForDate(NSDate()))
        default:
            handler(nil)
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler([timelineEntryForDate(NSDate(timeIntervalSinceNow: -1*24*60*60))])
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler([timelineEntryForDate(NSDate(timeIntervalSinceNow: 1*24*60*60))])
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // I will refresh this only next day
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let date = NSDate(timeIntervalSinceNow: 1*24*60*60)
        handler(cal.startOfDayForDate(date))
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        switch complication.family {
        case .UtilitarianSmall:
            let utilitarianSmallTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
            utilitarianSmallTemplate.textProvider = CLKSimpleTextProvider(text: ND.getNameDay())
            handler(utilitarianSmallTemplate)
        default:
            handler(nil)
        }
    }

    func requestedUpdateDidBegin() {
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications {
            server.reloadTimelineForComplication(complication)
        }
    }

    static func extendComplications() {
        let server = CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications {
            server.extendTimelineForComplication(complication)
        }
    }
}