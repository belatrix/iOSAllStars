//
//  LocationWebModel.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 26/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class LocationWebModel: NSObject {

    class func listLocations(_ token : String, withSuccessful success : @escaping Locations, withError error : @escaping ErrorResponse) {
        
        let path = "api/employee/location/list/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: token) { (response) in
            
            if response.successful, let JSON = response.JSON as? [[String : Any]]{
                
                var arrayTemp = [LocationBE]()
                
                for obj in JSON{
                    arrayTemp.append(LocationBE.parse(obj))
                }
                
                success(arrayTemp)
                
            }else{
                error(ErrorResponseBE.parse(response.JSON as? [String : Any], withCode: response.statusCode))
            }
            
        }
    }
    
    
}
