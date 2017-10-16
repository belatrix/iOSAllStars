//
//  AchievementBC.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 9/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AchievementBC: NSObject {

    class func listAchievementsToUser(_ objUser: UserBE, withSuccessful success : @escaping Achievements, withAlertInformation alertInformation : @escaping AlertInformation) {
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        AchievementWebModel.listAchievementsToUser(objUser, withSession: objSession!, withSuccessful: { (arrayAchievements) in
            
            success(arrayAchievements)
            
        }) { (errorResponse) in
            
            alertInformation("generic_title_problem".localized, "server_error".localized)
        }        
    }
}
