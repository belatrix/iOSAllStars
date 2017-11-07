//
//  ContactWebModel.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 11/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ContactWebModel: NSObject {

    @discardableResult class func listEmployee(_ objSession: SessionBE, withSearchText searchText: String, withSuccessful success : @escaping Contacts, withError error : @escaping ErrorResponse)  -> URLSessionDataTask{
        
        var path = "api/employee/list/"

        if searchText.count != 0{
            path = "\(path)?search=\(searchText)"
        }

        return CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayUsers = CDMWebResponse.getArrayDictionary(JSON["results"])
                let nextPage = CDMWebResponse.getString(JSON["next"])
                
                var arrayTemp = [UserBE]()
                
                for obj in arrayUsers{
                    arrayTemp.append(UserBE.parse(obj))
                }
                
                success(arrayTemp, nextPage)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
        }
    }
    
    
    @discardableResult class func listEmployeeToPage(_ page : String, withSession objSession : SessionBE, withSuccessful success : @escaping Contacts, withError error : @escaping ErrorResponse) -> URLSessionDataTask{
        
        return CDMWebSender.doGETTokenToURL(page, withPath: "", withParameter: nil, withToken: objSession.session_token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [String : Any]{
                
                let arrayUsers = CDMWebResponse.getArrayDictionary(JSON["results"])
                let nextPage = CDMWebResponse.getString(JSON["next"])
                
                var arrayTemp = [UserBE]()
                
                for obj in arrayUsers{
                    arrayTemp.append(UserBE.parse(obj))
                }
                
                success(arrayTemp, nextPage)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
        }
    }
    
}
