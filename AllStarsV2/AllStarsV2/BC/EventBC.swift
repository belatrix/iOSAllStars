//
//  EventBC.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/23/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EventBC: NSObject {
    
    class func listUserEvents(withSuccessful success : @escaping Events, withAlertInformation alertInformation :
        @escaping AlertInformation) {
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized,"token_invalid".localized)
            return
        }
        
        EventWebModel.listUserEvents(withSession: objSession!, withSuccess: { (arrayEvents, nextPage) in
            
            success(arrayEvents, nextPage)
            
        }, withError: { (errorResponse) in
            
            alertInformation("generic_title_problem".localized, errorResponse.message)
            
        })
        
    }
    
    class func listLocalEvents(withSuccessful success : @escaping Events, withAlertInformation alertInformation :
        @escaping AlertInformation){
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        EventWebModel.listLocalEvents(withSession: objSession!, withSuccess: { (arrayEvents, nextPage) in
            success(arrayEvents, nextPage)
        }) { (errorResponse) in
            alertInformation("generic_title_problem".localized, errorResponse.message)
        }
        
    }
    
    class func listOtherEvents(withSuccessful success : @escaping Events, withAlertInformation alertInformation :
        @escaping AlertInformation){
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        EventWebModel.listOtherEvents(withSession: objSession!, withSuccess: { (arrayEvents, nextPage) in
            success(arrayEvents, nextPage)
        }) { (errorResponse) in
            alertInformation("generic_title_problem".localized, errorResponse.message)
        }
        
    }
    
    @discardableResult class func listEventToPage(_ page : String, withSuccessful success : @escaping Events, withAlertInformation alertInformation : @escaping AlertInformation) ->URLSessionDataTask?{
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return nil
        }
        
        return EventWebModel.listEventToPage(page, withSession: objSession!, withSuccessfil: { (arrayEvents, nextPage) in
            success(arrayEvents, nextPage)
        }, withError: { (errorResponse) in
            alertInformation("generic_title_problem".localized, errorResponse.message)
        })
        
    }
    
    class func getEventDetails(toEvent objEvent : EventBE, withSuccessful success : @escaping Event, withAlertInformation alertInformation : @escaping AlertInformation){
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        EventWebModel.getEventDetails(toEvent: objEvent, withSession: objSession!, withSuccess: { (event) in
            
            success(event)
            
        }) { (errorResponse) in
            
            alertInformation("generic_title_problem".localized, errorResponse.message)
            
        }
        
    }
    
    class func updateUserToEvent(toEvent objEvent : EventBE, withSuccessful success : @escaping Event, withAlertInformation alertInformation : @escaping AlertInformation){
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        EventWebModel.updateUserToEvent(toEvent: objEvent, withAction: !objEvent.event_is_registered, withSession: objSession!, withSuccess: { (event) in
            success(event)
        }) { (errorResponse) in
            alertInformation("generic_title_problem".localized, errorResponse.message)
        }
        
    }
    
    class func listEventActivities(toEvent objEvent : EventBE, withSuccess success : @escaping Activities, withAlertInformation alertInformation :
        @escaping AlertInformation){
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        EventWebModel.listEventActivities(toEvent: objEvent, withSession: objSession!, withSuccess: { (arrayActivites) in
            success(arrayActivites)
        }) { (errorResponse) in
            alertInformation("generic_title_problem".localized, errorResponse.message)
        }
        
    }

}
