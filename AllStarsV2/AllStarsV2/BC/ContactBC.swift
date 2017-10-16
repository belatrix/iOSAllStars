//
//  ContactBC.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 11/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ContactBC: NSObject {

    @discardableResult class func listEmployee(withSearchText searchText: String, withSuccessful success : @escaping Contacts, withAlertInformation alertInformation : @escaping AlertInformation) -> URLSessionDataTask?{
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return nil
        }
        
        return ContactWebModel.listEmployee(objSession!, withSearchText: searchText, withSuccessful: { (arrayContacts, nextPage) in
            
            success(arrayContacts, nextPage)
            
        }) { (errorResponse) in
            
            alertInformation("generic_title_problem".localized, errorResponse.message)
        }
    }
    
    
    @discardableResult class func listEmployeeToPage(_ page : String, withSuccessful success : @escaping Contacts, withAlertInformation alertInformation : @escaping AlertInformation) -> URLSessionDataTask? {
        
        let objSession = UserBC.getUserSession()
        
        if objSession?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return nil
        }
        
        return ContactWebModel.listEmployeeToPage(page, withSession: objSession!, withSuccessful: { (arrayContacts, nextPage) in
            
            success(arrayContacts, nextPage)
            
        }) { (errorResponse) in
            
            alertInformation("generic_title_problem".localized, errorResponse.message)
        }
        
    }
    
}
