//
//  AnimationTransitionFactory.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 24/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AnimationTransitionFactory: NSObject {

    class func getAnimationTransitionTo(controllerOrigin origin: UIViewController, withDestinationController destination: UIViewController, withOperation operation: UINavigationControllerOperation, withNavigationController navController : UINavigationController) -> (transition : ControllerTransition?, interactiveTransition: InteractiveTransition?){
        
        if (origin is SplashViewController && destination is LoginViewController){
            
            let transition = SplashLoginTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is LoginViewController && destination is ForgotPasswordViewController) || (origin is ForgotPasswordViewController && destination is LoginViewController){
            
            let transition = LoginPasswordTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is LoginViewController && destination is CreateNewAccountViewController) || (origin is CreateNewAccountViewController && destination is LoginViewController){
            
            let transition = LoginCreateUserTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is LoginViewController && destination is ChangePasswordViewController) || (origin is ChangePasswordViewController && destination is LoginViewController){
            
            let transition = LoginChangePasswordAnimation(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is LoginViewController && destination is SWRevealViewController) || (origin is CompleteProfileViewController && destination is SWRevealViewController){
            
            let transition = LoginTabBarTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is UserProfileViewController && destination is AchievementDetailViewController) || (destination is UserProfileViewController && origin is AchievementDetailViewController){
            
            let transition = AchievementToDetailTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is UserProfileViewController && destination is CategoryDetailViewController && operation == .push) || (destination is UserProfileViewController && origin is CategoryDetailViewController && operation == .pop){
            
            let transition = CategoryToDetailTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is UserProfileViewController && destination is EditProfileViewController) || (destination is UserProfileViewController && origin is EditProfileViewController){
            
            let transition = ProfileToEditProfileTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is ContactsViewController && destination is UserProfileViewController) || (destination is ContactsViewController && origin is UserProfileViewController){
            
            let transition = ContactsToProfileTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is RankingViewController && destination is UserProfileViewController) || (destination is RankingViewController && origin is UserProfileViewController){
            
            let transition = RankingToProfileTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else if (origin is CategoryDetailViewController && destination is UserProfileViewController && operation == .push) || (origin is UserProfileViewController && destination is CategoryDetailViewController && operation == .pop){
            
            let transition = DetailCategoryTransition(withOrigin: origin, withDestination: destination, withOperation: operation)
            return (transition, transition.createInteractiveTransition(navigationController: navController))
            
        }else{
            
            return (nil, nil)
        }
    }
}
