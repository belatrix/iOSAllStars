//
//  CDMKeyChain.swift
//  InicioSesion
//
//  Created by Kenyi Rodriguez on 6/01/17.
//  Copyright © 2017 Core Data Media. All rights reserved.
//

import UIKit

public class CDMKeyChain: NSObject {
    
    
    
    //MARK: - Público
    
    
    public class func dataDesdeKeychainConCuenta(_ cuenta : String, conServicio servicio : String) -> Data? {
        
        let tienePermiso = self.dispositivoCorrecto()
        
        if tienePermiso == true {
            
            let data = self.keychainDataConCuenta(cuenta, conServicio: servicio)
            return data
            
        }else{
            
            exit(-1)
        }
        
        return nil
    }
    
    
    
    @discardableResult public class func guardarDataEnKeychain(_ data : Data, conCuenta cuenta : String, conServicio servicio : String) -> Bool {
        
        let tienePermiso = self.dispositivoCorrecto()
        
        if tienePermiso == true {
            
            let guardado = self.guardarEnKeychain(data, conCuenta: cuenta, conServicio: servicio)
            return guardado
            
        }else{
            
            exit(-1)
        }
        
        return false
    }
    
    
    
    public class func eliminarKeychain(){
        
        let arrayElementosSeguridad = [kSecClassGenericPassword,
                                       kSecClassInternetPassword,
                                       kSecClassCertificate,
                                       kSecClassKey,
                                       kSecClassIdentity]
        
        for elementoSeguridad in arrayElementosSeguridad{
            
            let query = [kSecClass as String : elementoSeguridad]
            SecItemDelete(query as CFDictionary)
        }
    }
    
    
    //MARK: - Privado
    
    
    private class func dispositivoCorrecto() -> Bool {
        
        //Descomentar para producción, ya que en el simulador tampoco deja ejecutar para evitar injections en el código.
        /*
        if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") || FileManager.default.fileExists(atPath: "/bin/bash") || FileManager.default.fileExists(atPath: "/usr/sbin/sshd") || FileManager.default.fileExists(atPath: "/etc/apt") {
            
            return false
            
        }else{
            
            let texto = "1234567890"
            
            do{
                try texto.write(toFile: "/private/cache.txt", atomically: true, encoding: String.Encoding.utf8)
                return false
                
            }catch{
                
                if UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
                    return false
                }else{
                    return true
                }
            }
        }*/
        
        return true
    }
    
    
    private class func keychainDataConCuenta(_ cuenta : String, conServicio servicio : String) -> Data? {
        
        let query : [String : Any] = [kSecClass as String                   : kSecClassGenericPassword as String,
                                      kSecAttrAccount as String             : cuenta,
                                      kSecAttrService as String             : servicio,
                                      kSecMatchCaseInsensitive as String    : kCFBooleanTrue,
                                      kSecReturnData as String              : kCFBooleanTrue]
        
        var resultado : AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &resultado)
        
        if status == noErr && resultado != nil {
            return resultado as? Data
        }
        
        return nil
        
    }
    
    
    
    private class func guardarEnKeychain(_ data : Data, conCuenta cuenta : String, conServicio servicio : String) -> Bool {
        
        let keychainData = data as CFData
        
        let query : [String : Any] = [kSecClass as String            : kSecClassGenericPassword as String,
                                      kSecAttrAccount as String      : cuenta,
                                      kSecAttrService as String      : servicio,
                                      kSecValueData as String        : keychainData as Data,
                                      kSecAttrAccessible as String   : kSecAttrAccessibleWhenUnlocked as String]
        
        var keychainError = noErr
        
        keychainError = SecItemAdd(query as CFDictionary, nil)
        
        return keychainError == noErr ? true : false
    }
    

}
