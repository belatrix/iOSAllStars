//
//  CategoryWebModel.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 2/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class CategoryWebModel: NSObject {

    class func listCategories(toUser objUser: UserBE, withSession objSession : SessionBE, withSuccessful success : @escaping Categories, withError error : @escaping ErrorResponse) {
        
        let path = "api/star/\(objUser.user_pk)/list/group/category/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayCategories = CDMWebResponse.getArrayDictionary(JSON["results"])
                
                var arrayTemp = [CategoryBE]()
                
                for obj in arrayCategories{
                    arrayTemp.append(CategoryBE.parse(obj))
                }
                
                success(arrayTemp)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
            
        }
    }
    
    
    class func listStarsToCategory(_ objCategory : CategoryBE, toUser objUser: UserBE, toSession objSession : SessionBE, withSuccessful success : @escaping Stars, withError error : @escaping ErrorResponse ){
        
        let path = "api/star/\(objUser.user_pk)/list/group/category/\(objCategory.category_pk)/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayStarsUser = CDMWebResponse.getArrayDictionary(JSON["results"])
                
                var arrayTemp = [StarUserBE]()
                
                for obj in arrayStarsUser{
                    arrayTemp.append(StarUserBE.parse(obj))
                }
                
                success(arrayTemp)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
            
        }
    }
    
}
