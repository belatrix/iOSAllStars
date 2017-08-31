//
//  AchievementBE.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 8/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AchievementBE: NSObject {

    var achievement_pk          : Int = 0
    var achievement_date        = Date()
    var achievement_to_user     = UserBE()
    var achievement_assigned_by = UserBE()
    var achievement_badge       = BadgeBE()
    
    class func parse(_ objDic : [String : Any]) -> AchievementBE{
        
        let objBE = AchievementBE()
        
        objBE.achievement_pk            = CDMWebResponse.getInt(objDic["pk"])
        objBE.achievement_assigned_by   = UserBE.parse(CDMWebResponse.getDictionary(objDic["assigned_by"]))
        objBE.achievement_to_user       = UserBE.parse(CDMWebResponse.getDictionary(objDic["to_user"]))
        objBE.achievement_badge         = BadgeBE.parse(CDMWebResponse.getDictionary(objDic["badge"]))
        
        if let date = CDMDateManager.convertirTexto(CDMWebResponse.getString(objDic["date"]), enDateConFormato: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"){
            objBE.achievement_date = date
        }
        
        return objBE
    }
    
}
