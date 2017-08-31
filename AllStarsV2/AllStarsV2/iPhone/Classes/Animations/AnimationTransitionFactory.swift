//
//  AnimationTransitionFactory.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 24/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AnimationTransitionFactory: NSObject {

    class func getAnimationTransitionTo(controllerOrigin origin: UIViewController, withDestinationController destination: UIViewController, withOperation operation: UINavigationControllerOperation) -> ControllerTransition?{
        
        if (origin is SplashViewController && destination is LoginViewController){
            
            return SplashLoginTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            
        }else if (origin is LoginViewController && destination is ForgotPasswordViewController) || (origin is ForgotPasswordViewController && destination is LoginViewController){
            
            return LoginPasswordTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            
        }else if (origin is LoginViewController && destination is CreateNewAccountViewController) || (origin is CreateNewAccountViewController && destination is LoginViewController){
            
            return LoginCreateUserTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            
        }else if (origin is LoginViewController && destination is ChangePasswordViewController) || (origin is ChangePasswordViewController && destination is LoginViewController){
            
            return LoginChangePasswordAnimation(withOrigin: origin, withDestination: destination, withOperation: operation)
            
        }else if (origin is LoginViewController && destination is SWRevealViewController) || (origin is CompleteProfileViewController && destination is SWRevealViewController){
            
            return LoginTabBarTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            
        }else if (origin is UserProfileViewController && destination is AchievementDetailViewController) || (destination is UserProfileViewController && origin is AchievementDetailViewController){
            
            return AchievementToDetailTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            
        }else if (origin is UserProfileViewController && destination is CategoryDetailViewController) || (destination is UserProfileViewController && origin is CategoryDetailViewController){
            
            return CategoryToDetailTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            
        }else if (origin is UserProfileViewController && destination is EditProfileViewController) || (destination is UserProfileViewController && origin is EditProfileViewController){
            
            return ProfileToEditProfileTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            
        }else if (origin is ContactsViewController && destination is UserProfileViewController) || (destination is ContactsViewController && origin is UserProfileViewController){
            
            return ContactsToProfileTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            
        }

        return nil
    }
}
