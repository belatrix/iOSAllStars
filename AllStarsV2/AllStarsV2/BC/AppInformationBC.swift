//
//  AppInformationBC.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 13/10/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AppInformationBC: NSObject {

    static var sharedInstance = AppInformationBC()
    var appInformation = AppInformationBE()
    
    class func getAppInformation(){
        
        ConfigurationWS.getAppInformationWithSuccess({ (appInformation) in
            
            AppInformationBC.sharedInstance.appInformation = appInformation
            
        }) { (errorResponse) in
            
            AppInformationBC.sharedInstance.appInformation = AppInformationBE()
        }
    }
}
