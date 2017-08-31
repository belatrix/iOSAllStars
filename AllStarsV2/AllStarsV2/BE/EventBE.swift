//
//  EventBE.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/22/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EventBE: NSObject {
    var event_pk            : Int = 0
    var event_name          : String = ""
    var event_image         : String = ""
    var event_datetime      : Date = Date()
    var event_address       : String = ""
    var event_description   : String = ""
    var event_is_active     : Bool = false
    var event_is_registered : Bool = false
    var event_location      : LocationBE?
    
    class func parse(_ objDic : [String : Any]) -> EventBE {
        
        let objBE = EventBE()
        
        objBE.event_pk              = CDMWebResponse.getInt(objDic["pk"])
        objBE.event_name            = CDMWebResponse.getString(objDic["name"])
        objBE.event_image           = CDMWebResponse.getString(objDic["image"])
        objBE.event_address         = CDMWebResponse.getString(objDic["address"])
        objBE.event_description     = CDMWebResponse.getString(objDic["description"])
        objBE.event_is_active       = CDMWebResponse.getBool(objDic["is_active"])
        objBE.event_is_registered   = CDMWebResponse.getBool(objDic["is_registered"])
        objBE.event_location        = LocationBE.parse(CDMWebResponse.getDictionary(objDic["location"]))
        
        if let date = CDMDateManager.convertirTexto(CDMWebResponse.getString(objDic["datetime"]), enDateConFormato: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"){
            objBE.event_datetime = date
        }
        
 
        return objBE
    }
    
}
