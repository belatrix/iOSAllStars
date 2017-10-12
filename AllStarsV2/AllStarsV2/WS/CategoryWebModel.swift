//
//  CategoryWebModel.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 2/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class CategoryWebModel: NSObject {

    class func createKeyWord(_ keyWord: String, withSession objSession : SessionBE, withSuccessful success : @escaping KeyWord, withError error : @escaping ErrorResponse) {
        
        let path = "api/category/keyword/create/"
        let dic : [String : Any] = ["name" : keyWord.lowercased()]
        
        CDMWebSender.doPOSTTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: dic, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                success(KeywordBE.parse(JSON))
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
        }
    }
    
    
    class func listGeneralKeyWords(withSession objSession : SessionBE, withSuccessful success : @escaping KeyWords, withError error : @escaping ErrorResponse) {
        
        let path = "api/category/keyword/list/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [[String : Any]]{
                
                let arrayCategories = JSON
                
                var arrayTemp = [KeywordBE]()
                
                for obj in arrayCategories{
                    arrayTemp.append(KeywordBE.parse(obj))
                }
                
                success(arrayTemp)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
        }
    }
    
    
    class func listGeneralCategories(withSession objSession : SessionBE, withSuccessful success : @escaping Categories, withError error : @escaping ErrorResponse) {
        
        let path = "api/category/list/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [[String : Any]]{
                
                let arrayCategories = JSON
                
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
