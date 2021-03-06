//
//  UserWebModel.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 20/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class UserWebModel: NSObject {

    
    class func uploadPhoto(_ image: UIImage, toUserSession session: SessionBE, withSuccessful success: @escaping User, withError error: @escaping ErrorResponse) {
        
        let path = "api/employee/\(session.session_user_id)/avatar/"
        
        CDMWebSender.uploadRequest(image, withURL: Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: session.session_token) { (response) in
            
            self.getUserInformationById(session.session_user_id.intValue, withSession: session, withSuccessful: { (objUser) in
                success(objUser)
            }, withError: { (ErrorResponse) in
                error(ErrorResponse)
            })
        }
    }
    
        
    class func getUserInformationById(_ userId : Int, withSession session: SessionBE, withSuccessful success: @escaping User, withError error: @escaping ErrorResponse) {
        
        let path = "api/employee/\(userId)/"
        
        CDMWebSender.doGETTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil, withToken: session.session_token) { (response) in
            
            let JSON = response.JSON as? [String : Any]
            
            if response.successful{
                success(UserBE.parse(JSON!))
            }else{
                error(ErrorResponseBE.parse(JSON, withCode: response.statusCode))
            }
        }
        
    }
    
    
    class func updateUser(_ user: UserBE, withSession session: SessionBE, withSuccessful success: @escaping User, withError error: @escaping ErrorResponse) {
        
        let path = "api/employee/\(session.session_user_id)/update/"
        
        let dic : [String : Any] = ["first_name"    : user.user_first_name!,
                                    "last_name"     : user.user_last_name!,
                                    "skype_id"      : user.user_skype_id!,
                                    "location"      : user.user_location!.location_pk]
        
        CDMWebSender.doPATCHTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: dic, withToken: session.session_token) { (response) in
            
            let JSON = response.JSON as? [String : Any]
            
            if response.successful{
                success(UserBE.parse(JSON!))
            }else{
                error(ErrorResponseBE.parse(JSON, withCode: response.statusCode))
            }
        }

    }
    
    
    class func logInUsername(_ username: String, withPassword password: String, withSuccessful success : @escaping UserSession, withError error : @escaping ErrorResponse){
        
        let dic : [String : Any] = ["username" : username,
                                    "password" : password]
        
        let path = "api/employee/authenticate/"
        
        CDMWebSender.doPOSTToURL(Constants.WEB_SERVICES, withPath: path, withParameter: dic) { (response) in
            
            let JSON = response.JSON as? [String : Any]
            
            if response.successful{
                success(SessionBE.parse(JSON!))
            }else{
                error(ErrorResponseBE.parse(JSON, withCode: response.statusCode))
            }
            
        }
    }
    
    class func resetUserPassword(_ userSession : SessionBE, currentPassword : String, newPassword : String, withSuccessful success : @escaping UserSession, withError error : @escaping ErrorResponse) {
        
        let path = "api/employee/\(userSession.session_user_id)/update/password/"
        
        let dic : [String : Any] = ["current_password"  : currentPassword,
                                    "new_password"      : newPassword]
        
        CDMWebSender.doPOSTTokenToURL(Constants.WEB_SERVICES, withPath: path, withParameter: dic, withToken: userSession.session_token) { (response) in
            
            let JSON = response.JSON as? [String : Any]
            
            if response.successful{
                success(userSession)
            }else{
                error(ErrorResponseBE.parse(JSON, withCode: response.statusCode))
            }
        }
        
    }
    
    class func forgotPasswordToEmail(_ user_email: String, withSuccessful success : @escaping Success, withError error : @escaping ErrorResponse) {
        
        let path = "api/employee/reset/password/\(user_email)/"
        
        CDMWebSender.doGETToURL(Constants.WEB_SERVICES, withPath: path, withParameter: nil) { (response) in
            
            let JSON = response.JSON as? [String : Any]
            
            if response.successful{
                if let _ = response.JSON as? [String : Any] {
                    success(true)
                }else{
                    success(false)
                }
            }else{
                error(ErrorResponseBE.parse(JSON, withCode: response.statusCode))
            }
        }
    }
    
    class func createUserWithEmail(_ user_email: String, withSuccessful success : @escaping Success, withError error : @escaping ErrorResponse) {
        
        let path = "api/employee/create/"
        let dic : [String : Any] = ["email" : user_email]
        
        CDMWebSender.doPOSTToURL(Constants.WEB_SERVICES, withPath: path, withParameter: dic) { (response) in
            
            let JSON = response.JSON as? [String : Any]
            
            if response.successful{
                if let _ = response.JSON as? [String : Any] {
                    success(true)
                }else{
                    success(false)
                }
            }else{
                error(ErrorResponseBE.parse(JSON, withCode: response.statusCode))
            }
        }
    }
    
    class func registerDevice(_ idDevice: String, toSession session: SessionBE, withSuccessful success : @escaping Success, withError error : @escaping ErrorResponse) {
        
        let path = "api/employee/\(session.session_user_id)/register/device/"
        let dic : [String : Any] = ["employee_id" : session.session_user_id,
                                    "android_device" : "",
                                    "ios_device" : idDevice]
        
        CDMWebSender.doPOSTTokenToURL(Constants.WEB_SERVICES,
                                      withPath: path,
                                      withParameter: dic,
                                      withToken: session.session_token) { (response) in
            
            let isSuccess = (response.statusCode == 202 || response.statusCode == 200) ? true : false
            success(isSuccess)
                                        
        }
    }
    
}
