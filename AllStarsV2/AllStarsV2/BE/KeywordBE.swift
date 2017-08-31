//
//  KeywordBE.swift
//  AllStars
//
//  Created by Kenyi Rodriguez Vergara on 12/05/16.
//  Copyright © 2016 Belatrix SF. All rights reserved.
//

import UIKit

class KeywordBE: NSObject {

    var keyword_pk      : Int = 0
    var keyword_name    : String = ""
    
    class func parse(_ objDic : [String : Any]) -> KeywordBE{
        
        let objBE = KeywordBE()
        
        objBE.keyword_pk = CDMWebResponse.getInt(objDic["pk"])
        objBE.keyword_name = CDMWebResponse.getString(objDic["name"])
        
        return objBE
    }
}
