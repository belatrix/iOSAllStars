//
//  UserBC.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 20/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class UserBC: NSObject {

    class func uploadPhoto(_ photo: UIImage, withSuccessful success : @escaping User, withAlertInformation alertInformation : @escaping AlertInformation) {
        
        let objSession = UserBC.getUserSession()
        
        if objSession == nil || objSession!.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            
        }else {
            
            UserWebModel.uploadPhoto(photo, toUserSession: objSession!, withSuccessful: { (objUser) in
                
                UserBE.shareInstance = objUser
                success(objUser)
            }, withError: { (errorResponse) in
                alertInformation("generic_title_problem".localized, errorResponse.message)
            })
        }
    }
    
    class func getUserInformationById(_ userId: Int, withSuccessful success : @escaping User, withAlertInformation alertInformation : @escaping AlertInformation) {
        
        let objSession = UserBC.getUserSession()
        
        if objSession == nil || objSession!.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            
        }else {
            
            UserWebModel.getUserInformationById(userId, withSession: objSession!, withSuccessful: { (objUser) in
                
                success(objUser)
                
            }, withError: { (errorResponse) in
                alertInformation("generic_title_problem".localized, errorResponse.message)
            })
            
        }
    }
    
    
    class func updateInfoToUser(_ user : UserBE, withImage image: UIImage?, withSuccessful success : @escaping User, withAlertInformation alertInformation : @escaping AlertInformation) {
        
        let objSession = UserBC.getUserSession()
        
        if image == nil{
            alertInformation("app_name".localized, "select_image_profile".localized)
            
        }else if objSession == nil || objSession!.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            
        }else if (user.user_first_name == nil || user.user_first_name == "") {
            alertInformation("app_name".localized, "first_name_empty".localized)
            
        }else if (user.user_last_name == nil || user.user_last_name == "") {
            alertInformation("app_name".localized, "last_name_empty".localized)
        
        }else if (user.user_skype_id == nil || user.user_skype_id == "") {
            alertInformation("app_name".localized, "skype_is_empty".localized)

        }else if (user.user_location == nil) {
            alertInformation("app_name".localized, "location_empty".localized)
            
        }else {
            
            
            UserWebModel.updateUser(user, withSession: objSession!, withSuccessful: { (objUser) in
                
                UserBC.deleteSession()
                UserBC.saveSession(objSession!)
                
                UserBE.shareInstance = objUser
                
                success(objUser)
                
            }, withError: { (errorResponse) in
                alertInformation("generic_title_problem".localized, errorResponse.message)
            })
            
        }
        
    }
    
    
    class func resetUserPassword(withSession userSession: SessionBE, currentPassword : String?, newPassword : String?, repeatNewPassword : String?, withSuccessful success : @escaping UserSession, withAlertInformation alertInformation : @escaping AlertInformation) {
        
        if userSession.session_token == "" {
            alertInformation("app_name".localized, "token_invalid".localized)
            return
        }
        
        if (currentPassword == nil || currentPassword == "") {
            alertInformation("app_name".localized, "old_password_empty".localized)
            return
        }
        
        if (newPassword == nil || repeatNewPassword == nil || newPassword == "" || repeatNewPassword == "") {
            alertInformation("app_name".localized, "new_password_empty".localized)
            return
        }
        
        if (newPassword != repeatNewPassword) {
            alertInformation("app_name".localized, "new_password_match".localized)
            return
        }
        
        if (newPassword!.characters.count < Constants.MIN_PASSWORD_LENGTH) {
            let message = String.init(format: "new_password_length".localized, Constants.MIN_PASSWORD_LENGTH)
            alertInformation("app_name".localized,  message)
            return
        }
        
        UserWebModel.resetUserPassword(userSession, currentPassword: currentPassword!, newPassword: newPassword!, withSuccessful: { (objSession) in
            
            objSession.session_token = userSession.session_token
            objSession.session_password = newPassword!
            objSession.session_pwd_reset_required = false
            
            SessionBE.sharedInstance = objSession
            
            success(objSession)
            
        }) { (errorResponse) in
            
            self.deleteSession()
            alertInformation("generic_title_problem".localized, errorResponse.message)
        }
        
    }
    
    
    class func forgotPasswordToEmail(_ user_email: String?, withSuccessful success : @escaping Success, withAlertInformation alertInformation : @escaping AlertInformation) {
    
        if (user_email == nil || user_email == "") {
            alertInformation("app_name".localized, "email_is_empty".localized)
            return
        }
        
        UserWebModel.forgotPasswordToEmail("\(user_email!)@\(AppInformationBC.sharedInstance.appInformation.appInformation_emailDomain)", withSuccessful: { (isCorrect) in
            
            success(isCorrect)
            
        }) { (errorResponse) in
            
            alertInformation("generic_title_problem".localized, errorResponse.message)
        }
    }
    
    
    class func logInUsername(_ username: String?, withPassword password: String?, withSuccessful success : @escaping UserSession, sessionProfileIncomplete profileIcomplete: @escaping UserSession, sessionNeedResetPassword resetPassword: @escaping UserSession, withError error : @escaping AlertInformation){
        
        if username == nil || username!.trim().isEmpty {
            
            error("app_name".localized, "username_empty".localized)
            
        }else if password == nil || password!.trim().isEmpty {
            
            error("app_name".localized, "password_empty".localized)
            
        }else{
            
            UserWebModel.logInUsername(username!, withPassword: password!, withSuccessful: { (objSession) in

                objSession.session_user = username!
                objSession.session_password = password!
                
                self.saveSession(objSession)
                
                if objSession.session_state == SessionBE.SessionState.session_profileComplete{
                    UserBC.saveSession(objSession)
                    success(objSession)
                }else if objSession.session_state == SessionBE.SessionState.session_profileIncomplete{
                    profileIcomplete(objSession)
                }else{
                    resetPassword(objSession)
                }

            }, withError: { (errorResponse) in

                error("generic_title_problem".localized, errorResponse.message)
            })
        }
    }
    
    
    public class func saveSession(_ objSession : SessionBE) -> Void {
        
        CDMKeyChain.eliminarKeychain()
        
        SessionBE.sharedInstance = objSession
        CDMKeyChain.guardarDataEnKeychain(NSKeyedArchiver.archivedData(withRootObject: objSession), conCuenta: "Login", conServicio: "dataUser")
    }
    
    
    
    public class func getUserSession() -> SessionBE?{
        
        if SessionBE.sharedInstance != nil {
            return SessionBE.sharedInstance
        }
        
        if let dataUser = CDMKeyChain.dataDesdeKeychainConCuenta("Login", conServicio: "dataUser") {
            
            let objUser = NSKeyedUnarchiver.unarchiveObject(with: dataUser) as? SessionBE
            SessionBE.sharedInstance = objUser
            return objUser
        }
        
        return nil
        
    }
    
    
    
    public class func deleteSession() -> Void{
        
        SessionBE.sharedInstance = nil
        CDMKeyChain.eliminarKeychain()
        
    }
}
