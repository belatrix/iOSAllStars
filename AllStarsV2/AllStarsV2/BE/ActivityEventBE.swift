//
//  ActivityEventBE.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/23/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ActivityEventBE: NSObject {
    
    var activity_pk               : Int = 0
    var activity_description      : String = ""
    var activity_event            : String = ""
    var activity_datetime         : Date = Date()
    
    class func parse(_ objDic : [String : Any]) -> ActivityEventBE {
        
        let objBE = ActivityEventBE()
        
        objBE.activity_pk           = CDMWebResponse.getInt(objDic["pk"])
        objBE.activity_description  = CDMWebResponse.getString(objDic["text"])
        objBE.activity_event        = CDMWebResponse.getString(objDic["event"])
        
        if let date = CDMDateManager.convertirTexto(CDMWebResponse.getString(objDic["datetime"]), enDateConFormato: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"){
            objBE.activity_datetime = date
        }
        
        return objBE
        
        
    }
    
}
