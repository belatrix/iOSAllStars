//
//  UserBE.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 20/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class UserBE: NSObject {

    var user_pk                     : Int = 0
    var user_username               : String = ""
    var user_password               : String = ""
    var user_token                  : String = ""
    var user_avatar                 : String = ""
    var user_current_month_score    : Int = 0
    var user_current_year_score     : Int = 0
    var user_email                  : String = ""
    var user_first_name             : String? = ""
    var user_is_active              : Int = 0
    var user_last_month_score       : Int = 0
    var user_last_name              : String? = ""
    var user_last_year_score        : Int = 0
    var user_level                  : Int = 0
    var user_role_id                : Int = 0
    var user_role_name              : String = ""
    var user_skype_id               : String? = ""
    var user_total_score            : Int = 0
    var user_base_profile_complete  : Bool = false
    var user_needs_reset_password   : Bool = false
    var user_blocked                : Bool = false
    var user_active                 : Bool = false
    var user_location               : LocationBE?
    var user_color                  : UIColor = .darkGray
    var user_value                  : Int = 0
    
    
    static var shareInstance : UserBE?
    
    
    class func parse(_ objDic : [String : Any]) -> UserBE{
        
        let objBE = UserBE()
        
        objBE.user_pk                       = CDMWebResponse.getInt(objDic["pk"])
        objBE.user_token                    = CDMWebResponse.getString(objDic["token"])
        objBE.user_current_month_score      = CDMWebResponse.getInt(objDic["current_month_score"])
        objBE.user_current_year_score       = CDMWebResponse.getInt(objDic["current_year_score"])
        objBE.user_email                    = CDMWebResponse.getString(objDic["email"])
        objBE.user_first_name               = CDMWebResponse.getString(objDic["first_name"]).lowercased().capitalized
        objBE.user_is_active                = CDMWebResponse.getInt(objDic["is_active"])
        objBE.user_last_month_score         = CDMWebResponse.getInt(objDic["last_month_score"])
        objBE.user_last_name                = CDMWebResponse.getString(objDic["last_name"]).lowercased().capitalized
        objBE.user_last_year_score          = CDMWebResponse.getInt(objDic["last_year_score"])
        objBE.user_level                    = CDMWebResponse.getInt(objDic["level"])
        objBE.user_role_id                  = CDMWebResponse.getInt(objDic["role"])
        objBE.user_role_name                = CDMWebResponse.getString((objDic["role"] as? [String : Any])?["name"])
        objBE.user_total_score              = CDMWebResponse.getInt(objDic["total_score"])
        objBE.user_username                 = CDMWebResponse.getString(objDic["username"])
        objBE.user_base_profile_complete    = CDMWebResponse.getBool(objDic["is_base_profile_complete"])
        objBE.user_blocked                  = CDMWebResponse.getBool(objDic["is_blocked"])
        objBE.user_active                   = CDMWebResponse.getBool(objDic["is_active"])
        objBE.user_avatar                   = CDMWebResponse.getString(objDic["avatar"])
        objBE.user_skype_id                 = CDMWebResponse.getString(objDic["skype_id"])
        objBE.user_value                    = CDMWebResponse.getInt(objDic["value"])
        
        if let location = LocationBE.parseToUserBE(CDMWebResponse.getDictionary(objDic["location"])){
            objBE.user_location = location
        }else{
            objBE.user_location = LocationBE()
        }
        
        let red = CGFloat(arc4random()%200)/255.0
        let green = CGFloat(arc4random()%200)/255.0
        let blue = CGFloat(arc4random()%200)/255.0
        objBE.user_color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return objBE
    }
    
}
