//
//  ConfigurationWS.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 13/10/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ConfigurationWS: NSObject {

    class func getAppInformationWithSuccess(_ success : @escaping AppConfiguration, withError error : @escaping ErrorResponse) {
        
        let path = "api/admin/site/info/"
        
        CDMWebSender.doGETToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil) { (response) in
            
            if response.successful {
                
                if let objDic = response.JSON as? [String : Any] {
                    success(AppInformationBE.parse(objDic))
                }else{
                    success(AppInformationBE())
                }
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
            
        }
    }
}
