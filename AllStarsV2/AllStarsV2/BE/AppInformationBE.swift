//
//  AppInformationBE.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 13/10/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AppInformationBE: NSObject {

    var appInformation_site             = "https://bxconnect.herokuapp.com"
    var appInformation_emailDomain      = "belatrixsf.com"
    var appInformation_backendVersion   = "2.0"
    
    class func parse(_ objDic : [String : Any]) -> AppInformationBE{
        
        let objBE = AppInformationBE()
        
        objBE.appInformation_site = CDMWebResponse.getString(objDic["site"])
        objBE.appInformation_emailDomain = CDMWebResponse.getString(objDic["email_domain"])
        objBE.appInformation_backendVersion = CDMWebResponse.getString(objDic["backend_version"])
        
        return objBE
    }
}
