//
//  RateUserBE.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 8/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class StarUserBE: NSObject {

    var star_fromUser       = UserBE()
    var star_category       = CategoryBE()
    var star_keyword        = KeywordBE()
    var star_comment        : String = ""
    var star_date           = Date()
    var star_explainDetail  = false
    
    
    class func parse(_ objDic : [String : Any]) -> StarUserBE{
        
        let objBE = StarUserBE()
        
        objBE.star_comment  = CDMWebResponse.getString(objDic["text"])
        objBE.star_keyword  = KeywordBE.parse(CDMWebResponse.getDictionary(objDic["keyword"]))
        objBE.star_fromUser = UserBE.parse(CDMWebResponse.getDictionary(objDic["from_user"]))
        objBE.star_category = CategoryBE.parse(CDMWebResponse.getDictionary(objDic["category"]))
        
        if let date = CDMDateManager.convertirTexto(CDMWebResponse.getString(objDic["date"]), enDateConFormato: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"){
            objBE.star_date = date
        }
        
        return objBE
    }
    
}
