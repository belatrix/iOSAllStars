//
//  AboutEventViewController.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/29/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit
import EventKit

class AboutEventViewController: UIViewController {
    
    @IBOutlet weak var lblDetailBody: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnAddEvent: UIButton!
    
    
    let eventStore      : EKEventStore = EKEventStore()
    var eventExists     : Bool = false
    var objEvent        : EventBE!
    var event           : EKEvent!
    
    
    func updateEventInfo(){
        self.lblDetailBody.text = self.objEvent.event_description
        self.lblLocation.text   = "\(self.objEvent.event_location!.location_name), \(self.objEvent.event_address)"
    }
    
    func setEventDate(){
        self.event = EKEvent(eventStore: self.eventStore)
        self.event.title         = self.objEvent.event_name
        self.event.startDate     = self.objEvent.event_datetime
        self.event.endDate       = self.objEvent.event_datetime
        self.event.notes         = self.objEvent.event_description
        self.event.calendar      = eventStore.defaultCalendarForNewEvents
    }
    //MARK: - Actions
    
    //Checks permissions
    @IBAction func btnAddToCalender(_ sender: Any) {
        let status = EKEventStore.authorizationStatus(for: .event)
        
        if status == .authorized {
            self.addEventToCalender()
        }else{
            CDMUserAlerts.showSimpleAlert(title: "Need Permission".localized, withMessage: "The app needs permission to use calendar".localized,
                                          withAcceptButton: "OK".localized, withController: self, withCompletion: nil)
        }
        
    }
    
    //MARK: - EventControllers
    
    //Checks if the current event is already added to calender
    func checkIfEventExists(){
        let predicate = eventStore.predicateForEvents(withStart: event.startDate, end: event.endDate.addingTimeInterval(60*60), calendars: nil)
        let existingEvents = eventStore.events(matching: predicate)
        for singleEvent in existingEvents{
            if event.title == singleEvent.title && event.startDate == singleEvent.startDate {
                self.eventExists = true
                self.btnAddEvent.setTitle("Remove from Calender".localized, for: .normal)
            }else{
                self.eventExists = false
                self.btnAddEvent.setTitle("Add to Calender".localized, for: .normal)
            }
        }
    }
    
    //Adds or Removes Event from calender
    func addEventToCalender(){
        self.setEventDate()
        
        if !self.eventExists{
            do{
                try eventStore.save(event, span: EKSpan.thisEvent)
                CDMUserAlerts.showSimpleAlert(title: "Event Added".localized,
                                              withMessage: "Event added correctly".localized,
                                              withAcceptButton: "OK".localized,
                                              withController: self, withCompletion: nil)
                self.eventExists = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.btnAddEvent.setTitle("Remove from Calender".localized, for: .normal)
                    self.view.layoutIfNeeded()
                })
            }catch{
                print("Error in saving event")
            }
        }else{
            do{
                let predicate = eventStore.predicateForEvents(withStart: event.startDate, end: event.endDate.addingTimeInterval(60*60), calendars: nil)
                let existingEvents = eventStore.events(matching: predicate)
                for singleEvent in existingEvents{
                    if event.title == singleEvent.title && event.startDate == singleEvent.startDate {
                        try self.eventStore.remove(singleEvent, span: .thisEvent)
                        CDMUserAlerts.showSimpleAlert(title: "Event Removed".localized,
                                                      withMessage: "Event removed correctly".localized,
                                                      withAcceptButton: "OK".localized,
                                                      withController: self, withCompletion: nil)
                        self.eventExists = false
                        UIView.animate(withDuration: 0.3, animations: {
                            self.btnAddEvent.setTitle("Add To Calender".localized, for: .normal)
                            self.view.layoutIfNeeded()
                        })
                    }
                }
            }catch{
                print("Error in deleting event")
            }
        }
        
    }
    
    
    //MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.updateEventInfo()
        self.setEventDate()
        self.checkIfEventExists()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
