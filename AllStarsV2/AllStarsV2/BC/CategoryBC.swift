//
//  CategoryBC.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 2/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class CategoryBC: NSObject {
    
    class func listCategories(toUser objUser: UserBE, withSuccessful success : @escaping Categories, withAlertInformation alertInformation : @escaping AlertInformation) {
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        CategoryWebModel.listCategories(toUser: objUser, withSession: objSession!, withSuccessful: { (arrayCategories) in
            
            success(arrayCategories)
            
        }) { (errorResponse) in
            
            alertInformation("generic_title_problem", "server_error".localized)
        }
        
    }
    
    class func listStartsToCategory(_ objCategory : CategoryBE, toUser objUser: UserBE, withSuccessful success : @escaping Stars, withAlertInformation alertInformation : @escaping AlertInformation) {
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        CategoryWebModel.listStarsToCategory(objCategory, toUser: objUser, toSession: objSession!, withSuccessful: { (arrayStars) in
            
            success(arrayStars)
            
        }) { (errorResponse) in
            
            alertInformation("generic_title_problem", "server_error".localized)
            
        }

    }
    
    
}
