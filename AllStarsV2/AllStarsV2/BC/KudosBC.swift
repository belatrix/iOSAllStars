//
//  KudosBC.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 10/10/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class KudosBC: NSObject {

    class func addStarToEmployee(_ toEmployee: UserBE, withKeyword keyword: KeywordBE?, withCategory category: CategoryBE?, withText text : String?, withSuccessful success : @escaping Success, alertInformation : @escaping AlertInformation){
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        if category == nil{
            alertInformation("app_name".localized, "select_category".localized)
            return
        }
        
        if keyword == nil{
            alertInformation("app_name".localized, "select_keyword".localized)
            return
        }
        
        KudosWS.addStarToEmployee(toEmployee, withKeyword: keyword!, withCategory: category!, withText: text, withSession: objSession!, withSuccessful: { (isSuccess) in
            success(isSuccess)
        }) { (errorResponse) in
            alertInformation("generic_title_problem".localized, errorResponse.message)
        }
    }
}
