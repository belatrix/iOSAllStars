//
//  CategoryBE.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 2/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class CategoryBE: NSObject {

    var category_pk                 : Int = 0
    var category_name               : String = ""
    var category_num_stars          : Int = 4
    var category_comment_required   = false
    
    class func parse(_ objDic : [String : Any]) -> CategoryBE{
        
        let objBE = CategoryBE()
        
        objBE.category_pk               = CDMWebResponse.getInt(objDic["pk"])
        objBE.category_name             = CDMWebResponse.getString(objDic["name"])
        objBE.category_num_stars        = CDMWebResponse.getInt(objDic["num_stars"])
        objBE.category_comment_required = CDMWebResponse.getBool(objDic["comment_required"])
        
        return objBE
    }
}
