//
//  CDMWebResponse.swift
//
//
//  Created by Kenyi Rodriguez on 8/04/16.
//  Copyright © 2016 Core Data Media. All rights reserved.
//

import UIKit

public class CDMWebResponse: NSObject {
    
    public var JSON            : Any?
    public var statusCode      : Int = 404
    public var respuestaNSData : Data?
    public var error           : Error?
    public var datosCabecera   : [String : Any]?
    public var token           : String?
    public var cookie          : String?
    public var successful      : Bool = false
    
    
    //MARK: - Métodos auxiliares
    
    public class func getArray(_ value : Any?) -> [Any] {
        
        if value == nil || value is NSNull || !(value is [Any]){
            
            return []
            
        }else{
            
            return value as! [Any]
        }
    }
    
    public class func getDictionary(_ value : Any?) -> [String : Any] {
        
        if value == nil || value is NSNull || !(value is [String : Any]){
            
            return [:]
            
        }else{
            
            return value as! [String : Any]
        }
    }
    
    public class func getArrayDictionary(_ value : Any?) -> [[String : Any]] {
        
        if value == nil || value is NSNull || !(value is [[String : Any]]){
            
            return []
            
        }else{
            
            return value as! [[String : Any]]
        }
    }
    
    public class func getColor(_ value : Any?) -> UIColor {
        
        if value == nil || value is NSNull || !(value is String){
            
            return .black
            
        }else{
            
            return CDMColorManager.colorFromHexString(value as! String, withAlpha: 1)
        }
    }
    
    public class func getString(_ value : Any?) -> String {
        
        if value == nil || value is NSNull || !(value is String){
            
            return ""
            
        }else{
            
            return value as! String
        }
    }
    
    public class func getBool(_ value : Any?) -> Bool {
        
        if value == nil || value is NSNull || !(value is Bool){
            
            return false
            
        }else{
            
            return value as! Bool
        }
    }
    
    public class func getInt(_ value : Any?) -> Int {
        
        if value == nil || value is NSNull || !(value is Int){
            
            return 0
            
        }else{
            
            return value as! Int
        }
    }
    
    public class func getDouble(_ value : Any?) -> Double {
        
        if value == nil || value is NSNull || !(value is Double){
            
            return 0
            
        }else{
            
            return value as! Double
        }
    }
    
    public class func getFloat(_ value : Any?) -> Float {
        
        if value == nil || value is NSNull || !(value is Float){
            
            return 0
            
        }else{
            
            return value as! Float
        }
    }
}
