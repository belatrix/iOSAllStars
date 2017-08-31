//
//  RankingWebModel.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 18/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class RankingWebModel: NSObject {

    @discardableResult class func listEmployeeByKind(_ kind: String, withSession objSession: SessionBE, withSuccessful success : @escaping Ranking, withError error : @escaping ErrorResponse)  -> URLSessionDataTask{
        
        let path = "api/employee/list/top/20/\(kind)/"
        
        return CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [[String : Any]]{
                
                let arrayUsers = JSON
                
                var arrayTemp = [UserBE]()
                
                for obj in arrayUsers{
                    arrayTemp.append(UserBE.parse(obj))
                }
                
                success(arrayTemp)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
        }
    }
    
}
