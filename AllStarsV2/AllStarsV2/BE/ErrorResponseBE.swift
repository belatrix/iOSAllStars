//
//  ErrorResponseBE.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 20/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ErrorResponseBE: NSObject {

    var state   : Int = 404
    var message : String = "server_error".localized
    
    
    class func parse(_ objDic : [String : Any]?, withCode statuscode: Int) -> ErrorResponseBE {
        
        let errorResponse = ErrorResponseBE()
        
        if let message = objDic?["detail"] as? String {
            errorResponse.message = message
        }
        
        errorResponse.state = statuscode
        
        return errorResponse
    }
}
