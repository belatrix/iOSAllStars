//
//  LocationBC.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 26/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class LocationBC: NSObject {

    class func listLocations(withSuccessful success : @escaping Locations, withAlertInformation alertInformation : @escaping AlertInformation) {
        
        let objUser = UserBC.getUserSession()
        
        if objUser?.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        LocationWebModel.listLocations(objUser!.session_token, withSuccessful: { (arrayLocations) in
            
            success(arrayLocations)
            
        }) { (errorResponse) in
            
            alertInformation("generic_title_problem".localized, "server_error".localized)
        }
        
    }
}
