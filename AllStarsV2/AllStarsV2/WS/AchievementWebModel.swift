//
//  AchievementWebModel.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 9/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AchievementWebModel: NSObject {

    class func listAchievementsToUser(_ objUser: UserBE, withSession objSession : SessionBE, withSuccessful success : @escaping Achievements, withError error : @escaping ErrorResponse) {
        
        let path = "api/star/\(objUser.user_pk)/badge/list/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayCategories = CDMWebResponse.getArrayDictionary(JSON["results"])
                
                var arrayTemp = [AchievementBE]()
                
                for obj in arrayCategories{
                    arrayTemp.append(AchievementBE.parse(obj))
                }
                
                success(arrayTemp)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
            
        }
    }
}
