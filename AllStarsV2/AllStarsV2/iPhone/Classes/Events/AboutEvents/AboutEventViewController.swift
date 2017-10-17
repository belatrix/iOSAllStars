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
    
    // MARK: - Properties
    
    @IBOutlet weak var lblDetailBody: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnAddEvent: UIButton!
    
    let eventStore      : EKEventStore = EKEventStore()
    var eventExists     : Bool = false
    var objEvent        : EventBE!
    var event           : EKEvent!
    
    
    
    
    // MARK: - My own methods
    
    func updateEventInfo() {
        self.lblDetailBody.text = self.objEvent.event_description
        let eventAddress        = (self.objEvent.event_address.characters.isEmpty == true) ? "" : ", \(self.objEvent.event_address)"
        self.lblLocation.text   = "\(self.objEvent.event_location!.location_name)\(eventAddress)" /* Si valor de 'eventAddress' no es vacío, se muestra junto con la coma (,). */
    }
    
    func setEventDate() {
        self.event              = EKEvent(eventStore: self.eventStore)
        self.event.title        = self.objEvent.event_name
        self.event.startDate    = self.objEvent.event_datetime
        self.event.endDate      = self.objEvent.event_datetime.addingTimeInterval(60 * 60)
        self.event.notes        = self.objEvent.event_description
        self.event.calendar     = eventStore.defaultCalendarForNewEvents
    }
    
    func checkIfEventExists() {
        let predicate = eventStore.predicateForEvents(withStart: event.startDate,
                                                      end: event.endDate.addingTimeInterval(60 * 60),
                                                      calendars: nil)
        let existingEvents = eventStore.events(matching: predicate)
        for singleEvent in existingEvents {
            self.eventExists = (event.title == singleEvent.title && event.startDate == singleEvent.startDate)
            
            let buttonTitle = (self.eventExists == false) ? "Add_to_Calender" : "Remove_from_Calender"
            self.btnAddEvent.setTitle(buttonTitle.localized,
                                      for: .normal)
        }
    }
    
    func addEventToCalender() {
        self.setEventDate()
        
        if self.eventExists == false { /* Se va a insertar el evento... */
            
            let differenceBetweenDates = CDMDateManager.calcularDiferenciaDeFechasEntre(self.event.startDate,
                                                                                        conFechaFinal: Date())
            if differenceBetweenDates.anios    > 0 ||
               differenceBetweenDates.meses    > 0 ||
               differenceBetweenDates.dias     > 0 ||
               differenceBetweenDates.horas    > 0 ||
               differenceBetweenDates.minutos  > 0 ||
               differenceBetweenDates.segundos > 0 { /* El evento ya pasó. No se hace la inserción. */
                
                CDMUserAlerts.showSimpleAlert(title: "older_event_title".localized,
                                              withMessage: "older_event_message".localized,
                                              withAcceptButton: "ok".localized,
                                              withController: self,
                                              withCompletion: nil)
            }
            else {
                do {
                    try eventStore.save(self.event,
                                        span: EKSpan.thisEvent)
                    CDMUserAlerts.showSimpleAlert(title: "Event_Added".localized,
                                                  withMessage: "Event_added_correctly".localized,
                                                  withAcceptButton: "ok".localized,
                                                  withController: self,
                                                  withCompletion: nil)
                    
                    self.eventExists = true
                    UIView.animate(withDuration: 0.3,
                                   animations: {
                                    
                        self.btnAddEvent.setTitle("Remove_from_Calender".localized,
                                                  for: .normal)
                        self.view.layoutIfNeeded()
                    })
                }
                catch {
                    CDMUserAlerts.showSimpleAlert(title: "event_added_error_title".localized,
                                                  withMessage: "event_added_error_message".localized,
                                                  withAcceptButton: "ok".localized,
                                                  withController: self,
                                                  withCompletion: nil)
                }
            }
        }
        else { /* Se va a eliminar el evento... */
            do {
                let predicate = eventStore.predicateForEvents(withStart: event.startDate,
                                                              end: event.endDate.addingTimeInterval(60 * 60),
                                                              calendars: nil)
                let existingEvents = eventStore.events(matching: predicate)
                for singleEvent in existingEvents{
                    if event.title == singleEvent.title && event.startDate == singleEvent.startDate {
                        try self.eventStore.remove(singleEvent, span: .thisEvent)
                        CDMUserAlerts.showSimpleAlert(title: "Event_Removed".localized,
                                                      withMessage: "Event_removed_correctly".localized,
                                                      withAcceptButton: "ok".localized,
                                                      withController: self, withCompletion: nil)
                        
                        self.eventExists = false
                        UIView.animate(withDuration: 0.3, animations: {
                            self.btnAddEvent.setTitle("Add_to_Calender".localized,
                                                      for: .normal)
                            self.view.layoutIfNeeded()
                        })
                    }
                }
            }
            catch {
                CDMUserAlerts.showSimpleAlert(title: "event_removed_error_title".localized,
                                              withMessage: "event_removed_error_message".localized,
                                              withAcceptButton: "ok".localized,
                                              withController: self,
                                              withCompletion: nil)
            }
        }
    }
    
    
    
    
    
    //MARK: - @IBAction/actions methods
    
    @IBAction func btnAddToCalender(_ sender: Any) {
        
        func showAlertForDeniedPermission() {
            
            unowned let viewController = self
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Need_Permissions".localized,
                                              message: "permission_use_calendar".localized,
                                              preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "ok".localized,
                                             style: UIAlertActionStyle.default,
                                             handler: { (action) in
                                                
                    guard let profileUrl = URL(string: "App-Prefs:root=AllStarsV2") else { return }
                    if UIApplication.shared.canOpenURL(profileUrl) {
                        UIApplication.shared.open(profileUrl,
                                                  options: [UIApplicationOpenURLOptionUniversalLinksOnly: false],
                                                  completionHandler: nil)
                        }
                })
                
                alert.addAction(okAction)
                viewController.present(alert,
                                       animated: true,
                                       completion: nil)
            }
        }
        
        switch EKEventStore.authorizationStatus(for: .event) {
            case .notDetermined:
                /* The user has not yet made a choice regarding whether this application may access the service. */
                
                EKEventStore().requestAccess(to: EKEntityType.event,
                                             completion: { [unowned self] (accessGranted, error) in
                    
                    if accessGranted == true {
                        self.addEventToCalender()
                    }
                    else {
                        showAlertForDeniedPermission()
                    }
                })
            
            case .denied:
                /* The user explicitly denied access to the service for this application. */
                
                showAlertForDeniedPermission()
            
            case .authorized:
                /* This application is authorized to access the service. */
                
                self.addEventToCalender()
            
            case .restricted:
                /* This application is not authorized to access the service. The user cannot change this application’s status, possibly due to active restrictions such as parental controls being in place. */
                
                CDMUserAlerts.showSimpleAlert(title: "calendar_restricted".localized,
                                              withMessage: "calendar_restricted_message".localized,
                                              withAcceptButton: "ok".localized,
                                              withController: self,
                                              withCompletion: nil)
            }
        
    }
    
    
    
    
    
    //MARK: - AboutEventViewController methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuraciones adicionales.
        self.updateEventInfo()
        self.setEventDate()
        self.checkIfEventExists()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
