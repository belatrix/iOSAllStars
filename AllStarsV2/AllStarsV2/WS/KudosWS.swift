//
//  KudosWS.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 25/09/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class KudosWS: NSObject {

    @discardableResult class func addStarToEmployee(_ toEmployee: UserBE, withKeyword keyword: KeywordBE, withCategory category: CategoryBE, withText text : String?, withSession objSession: SessionBE, withSuccessful success : @escaping Success, withError error : @escaping ErrorResponse)  -> URLSessionDataTask{
        
        let path = "api/star/\(objSession.session_user_id)/give/star/to/\(toEmployee.user_pk)/"
        
        let dic : [String : Any] = ["from_user" : objSession.session_user_id,
                                    "to_user"   : toEmployee.user_pk,
                                    "category"  : category.category_pk,
                                    "keyword"   : keyword.keyword_pk,
                                    "text"      : text ?? ""]
        
        return CDMWebSender.doPOSTTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: dic, withToken: objSession.session_token, withCompletion: { (response) in
            
            if response.successful {
                
                if let _ = response.JSON as? [String : Any] {
                    success(true)
                }else{
                    success(false)
                }
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
        })
    }
}
