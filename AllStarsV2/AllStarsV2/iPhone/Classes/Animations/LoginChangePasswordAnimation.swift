//
//  LoginChangePasswordAnimation.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 25/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class LoginChangePasswordAnimation: ControllerTransition {

    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! LoginViewController
        let toVC   = self.controllerDestination as! ChangePasswordViewController
        
        let containerView = context.containerView
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toVC.constraintCenterForm.constant = (UIScreen.main.bounds.size.height + toVC.viewFormUser.bounds.size.height) / 2
        toVC.constraintBottomViewLogo.constant = UIScreen.main.bounds.size.height
        toVC.constraintTopViewLogo.constant = -(UIScreen.main.bounds.size.height + toVC.viewLogo.frame.size.height)
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration * 0.5, animations: {
            
            fromVC.constraintCenterForm.constant = (UIScreen.main.bounds.size.height + fromVC.viewFormUser.bounds.size.height) / 2
            fromVC.constraintBottomViewLogo.constant = UIScreen.main.bounds.size.height
            fromVC.constraintTopViewLogo.constant = -(UIScreen.main.bounds.size.height + fromVC.viewLogo.frame.size.height)
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            fromView.backgroundColor = .clear
            
            UIView.animate(withDuration: duration * 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                
                toVC.constraintCenterForm.constant = toVC.initialValueConstraintCenterForm
                toVC.constraintBottomViewLogo.constant = 0
                toVC.constraintTopViewLogo.constant = 0
                
                containerView.layoutIfNeeded()
                
            }) { (_) in
                
                fromVC.constraintCenterForm.constant = fromVC.initialValueConstraintCenterForm
                fromVC.constraintBottomViewLogo.constant = 0
                fromVC.constraintTopViewLogo.constant = 0
                fromView.backgroundColor = .white
                
                context.completeTransition(true)
            }
        }
        
    }
    
    override func animatePop(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! ChangePasswordViewController
        let toVC   = self.controllerDestination as! LoginViewController
        
        let containerView = context.containerView
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toVC.constraintCenterForm.constant = (UIScreen.main.bounds.size.height + toVC.viewFormUser.bounds.size.height) / 2
        toVC.constraintBottomViewLogo.constant = UIScreen.main.bounds.size.height
        toVC.constraintTopViewLogo.constant = -(UIScreen.main.bounds.size.height + toVC.viewLogo.frame.size.height)
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration * 0.5, animations: {
            
            fromVC.constraintCenterForm.constant = (UIScreen.main.bounds.size.height + fromVC.viewFormUser.bounds.size.height) / 2
            fromVC.constraintBottomViewLogo.constant = UIScreen.main.bounds.size.height
            fromVC.constraintTopViewLogo.constant = -(UIScreen.main.bounds.size.height + fromVC.viewLogo.frame.size.height)
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            fromView.backgroundColor = .clear
            
            UIView.animate(withDuration: duration * 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                
                toVC.constraintCenterForm.constant = toVC.initialValueConstraintCenterForm
                toVC.constraintBottomViewLogo.constant = 0
                toVC.constraintTopViewLogo.constant = 0
                
                containerView.layoutIfNeeded()
                
            }) { (_) in
                
                fromVC.constraintCenterForm.constant = fromVC.initialValueConstraintCenterForm
                fromVC.constraintBottomViewLogo.constant = 0
                fromVC.constraintTopViewLogo.constant = 0
                fromView.backgroundColor = .white
                
                context.completeTransition(true)
            }
        }
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1
    }
}
