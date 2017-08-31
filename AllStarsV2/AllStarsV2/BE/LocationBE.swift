//
//  LocationBE.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 26/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class LocationBE: NSObject {

    var location_pk         : Int = 0
    var location_name       : String = ""
    var location_icon       : String = ""
    
    class func createLocationPlaceHolder(withTile title: String) -> LocationBE {
        
        let objBE = LocationBE()
        
        objBE.location_pk    = -1
        objBE.location_name  = title
        objBE.location_icon  = ""
        
        return objBE
    }
    
    class func parse(_ objDic : [String : Any]) -> LocationBE {
        
        let objBE = LocationBE()
        
        objBE.location_pk    = CDMWebResponse.getInt(objDic["pk"])
        objBE.location_name  = CDMWebResponse.getString(objDic["name"])
        objBE.location_icon  = CDMWebResponse.getString(objDic["icon"])
        
        return objBE
    }
    
    class func parseToUserBE(_ objDic : [String : Any]) -> LocationBE? {
        
        if let id = objDic["id"]{
            
            let objBE = LocationBE()
            
            objBE.location_pk    = CDMWebResponse.getInt(id)
            objBE.location_name  = CDMWebResponse.getString(objDic["name"])
            objBE.location_icon  = CDMWebResponse.getString(objDic["icon"])
            
            return objBE
        }else{
            return nil
        }
    
    }
    
}
