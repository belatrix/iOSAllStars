//
//  RankingBC.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 18/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

enum TypeKind : String{
    
    case totalScore         = "total_score"
    case level              = "level"
    case lastMonthScore     = "last_month_score"
    case currentMonthScore  = "current_month_score"
    case lastYearScore      = "last_year_score"
    case currentYearScore   = "current_year_score"
}

class RankingBC: NSObject {

    @discardableResult class func listEmployeeByKind(_ kind: String, withSuccessful success : @escaping Ranking, withAlertInformation alertInformation : @escaping AlertInformation) -> URLSessionDataTask?{
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return nil
        }
        
        return RankingWebModel.listEmployeeByKind(kind, withSession: objSession!, withSuccessful: { (arrayUsers) in
            
            success(arrayUsers)
            
        }) { (errorResponse) in
            
            alertInformation("generic_title_problem", errorResponse.message)
        }
    }

}
