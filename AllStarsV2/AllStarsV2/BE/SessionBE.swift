//
//  SessionBE.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 20/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit



class SessionBE: NSObject, NSCoding {
    
    var session_pwd_reset_required      : Bool = false
    var session_base_profile_complete   : Bool = false
    var session_user_id                 : Int  = 0
    var session_token                   : String = ""
    var session_user                    : String?
    var session_password                : String?
    var session_state                   : SessionState = .session_profileComplete
    
    enum SessionState: Int {
        
        case session_profileComplete    = 1
        case session_profileIncomplete  = 2
        case session_needResetPassword  = 3
    }
    
    public static var sharedInstance : SessionBE?
    
    
    override init() {
        super.init()
    }
    
    
    required public init(coder aDecoder: NSCoder) {
        
        self.session_pwd_reset_required     = aDecoder.decodeObject(forKey:"session_pwd_reset_required")    as! Bool
        self.session_base_profile_complete  = aDecoder.decodeObject(forKey:"session_base_profile_complete") as! Bool
        self.session_user_id                = aDecoder.decodeObject(forKey:"session_user_id")               as! Int
        self.session_token                  = aDecoder.decodeObject(forKey:"session_token")                 as! String
        self.session_user                   = aDecoder.decodeObject(forKey:"session_user")                  as? String
        self.session_password               = aDecoder.decodeObject(forKey:"session_password")              as? String
        self.session_state                  = SessionState(rawValue: aDecoder.decodeObject(forKey:"session_state") as! Int) ?? .session_profileComplete
    }
    
    
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.session_pwd_reset_required,      forKey: "session_pwd_reset_required")
        aCoder.encode(self.session_base_profile_complete,   forKey: "session_base_profile_complete")
        aCoder.encode(self.session_user_id,                 forKey: "session_user_id")
        aCoder.encode(self.session_token,                   forKey: "session_token")
        aCoder.encode(self.session_user!,                    forKey: "session_user")
        aCoder.encode(self.session_password!,                forKey: "session_password")
        aCoder.encode(self.session_state.rawValue,          forKey: "SessionState")
    }
    
    
    class func parse(_ objDic : [String : Any]) -> SessionBE {
        
        let objBE = SessionBE()
        
        objBE.session_pwd_reset_required    = CDMWebResponse.getBool(objDic["is_password_reset_required"])
        objBE.session_base_profile_complete = CDMWebResponse.getBool(objDic["is_base_profile_complete"])
        objBE.session_user_id               = CDMWebResponse.getInt(objDic["user_id"])
        objBE.session_token                 = CDMWebResponse.getString(objDic["token"])
        
        if objBE.session_pwd_reset_required == false {
            
            if objBE.session_base_profile_complete == true{
                objBE.session_state = .session_profileComplete
            }else{
                objBE.session_state = .session_profileIncomplete
            }
            
        }else{
            objBE.session_state = .session_needResetPassword
        }
        
        return objBE
    }

}
