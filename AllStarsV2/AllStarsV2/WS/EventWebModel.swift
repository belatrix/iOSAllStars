//
//  EventWebModel.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/22/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EventWebModel: NSObject {
    
    class func listUserEvents(withSession objSession : SessionBE, withSuccess success : @escaping Events, withError error : @escaping ErrorResponse){
        
        let path = "/api/event/upcoming/employee/\(objSession.session_user_id)/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayEvents = CDMWebResponse.getArrayDictionary(JSON["results"])
                let nextPage = CDMWebResponse.getString(JSON["next"])
                
                var arrayTemp = [EventBE]()
                
                for obj in arrayEvents{
                    arrayTemp.append(EventBE.parse(obj))
                }
                
                success(arrayTemp, nextPage)
                
            }
            else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
        }
        
    }
    
    class func listLocalEvents(withSession objSession : SessionBE, withSuccess success : @escaping Events, withError error : @escaping ErrorResponse){
        
        let path = "/api/event/local/employee/\(objSession.session_user_id)/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayEvents = CDMWebResponse.getArrayDictionary(JSON["results"])
                let nextPage = CDMWebResponse.getString(JSON["next"])
                
                var arrayTemp = [EventBE]()
                
                for obj in arrayEvents{
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    arrayTemp.append(EventBE.parse(obj))
                    
                }
                
                success(arrayTemp, nextPage)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
            
        }
        
    }
    
    class func listOtherEvents(withSession objSession : SessionBE, withSuccess success : @escaping Events, withError
        error : @escaping ErrorResponse){
        
        let path = "/api/event/others/employee/\(objSession.session_user_id)/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayEvents = CDMWebResponse.getArrayDictionary(JSON["results"])
                let nextPage = CDMWebResponse.getString(JSON["next"])
                
                var arrayTemp = [EventBE]()
                
                for obj in arrayEvents{
                    arrayTemp.append(EventBE.parse(obj))
                }
                
                success(arrayTemp, nextPage)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
            
        }
        
    }
    
    @discardableResult class func listEventToPage(_ page : String, withSession objSession : SessionBE, withSuccessfil success : @escaping Events, withError error : @escaping ErrorResponse) -> URLSessionDataTask{
        
        return CDMWebSender.doGETTokenToURL(page, withPath: "", withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayEvents = CDMWebResponse.getArrayDictionary(JSON["results"])
                let nextPage = CDMWebResponse.getString(JSON["next"])
                
                var arrayTemp = [EventBE]()
                
                for obj in arrayEvents{
                    arrayTemp.append(EventBE.parse(obj))
                }
                
                success(arrayTemp, nextPage)
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
        }
    }
    
    class func getEventDetails(toEvent objEvent : EventBE, withSession objSession : SessionBE,
                                  withSuccess success : @escaping Event, withError error : @escaping ErrorResponse){
        
        let path = "/api/event/\(objEvent.event_pk)/employee/\(objSession.session_user_id)/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            let JSON = response.JSON as? [String : Any]
            
            if response.successful{
                success(EventBE.parse(JSON!))
            }else{
                error(ErrorResponseBE.parse(JSON, withCode: response.statusCode))
            }
            
        }
        
    }
    
    class func updateUserToEvent(toEvent objEvent : EventBE, withAction action : Bool, withSession objSession :
        SessionBE, withSuccess success : @escaping Event, withError error : @escaping ErrorResponse){
        
        let path = "/api/event/\(objEvent.event_pk)/employee/\(objSession.session_user_id)/registration/\(action)/"
        
        CDMWebSender.doPATCHTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            let JSON = response.JSON as? [String : Any]
            
            if response.successful{
                success(EventBE.parse(JSON!))
            }else{
                error(ErrorResponseBE.parse(JSON, withCode: response.statusCode))
            }
            
        }
    }
    
    class func listEventActivities(toEvent objEvent : EventBE, withSession objSession : SessionBE, withSuccess success : @escaping Activities, withError
        error : @escaping ErrorResponse){
        
        let path = "/api/event/\(objEvent.event_pk)/activity/list/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayActivities = CDMWebResponse.getArrayDictionary(JSON["results"])
                
                var arrayTemp = [ActivityEventBE]()
                
                for obj in arrayActivities{
                    arrayTemp.append(ActivityEventBE.parse(obj))
                }
                
                success(arrayTemp)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
            
        }
        
    }
    
    
    

}
