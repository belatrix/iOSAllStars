//
//  BadgeBE.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 8/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class BadgeBE: NSObject {

    var badge_pk            : Int = 0
    var badge_name          : String = ""
    var badge_icon          : String = ""
    var badge_description   : String = ""
    var badge_sharing_text  : String = ""
    
    class func parse(_ objDic : [String : Any]) -> BadgeBE {
        
        let objBE = BadgeBE()
        
        objBE.badge_pk = CDMWebResponse.getInt(objDic["pk"])
        objBE.badge_name = CDMWebResponse.getString(objDic["name"])
        objBE.badge_icon = CDMWebResponse.getString(objDic["icon"])
        objBE.badge_description = CDMWebResponse.getString(objDic["description"])
        objBE.badge_sharing_text = CDMWebResponse.getString(objDic["sharing_text"])
        
        return objBE
    }
    
}
