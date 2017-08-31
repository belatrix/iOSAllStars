//
//  SplashLoginTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 19/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class SplashLoginTransition: ControllerTransition {
    
    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! SplashViewController
        let toVC   = self.controllerDestination as! LoginViewController
        
        let containerView = context.containerView
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        toView.backgroundColor = .clear
        toVC.constraintWidthLogo.constant = 68
        toVC.constraintHeightLogo.constant = 68
        toVC.lblNameCompany.alpha = 0
        toVC.constraintCenterForm.constant = (UIScreen.main.bounds.size.height + toVC.viewFormUser.bounds.size.height) / 2
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration * 0.5, animations: {
            
            fromView.backgroundColor = .white
            fromVC.imgLogo.alpha = 0
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            UIView.animate(withDuration: duration * 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                
                toVC.constraintWidthLogo.constant = 107
                toVC.constraintHeightLogo.constant = 107
                toVC.constraintCenterForm.constant = toVC.initialValueConstraintCenterForm
                toVC.lblNameCompany.alpha = 1
 
                containerView.layoutIfNeeded()
                
            }) { (_) in
                
                fromView.backgroundColor = fromVC.initialColor
                toView.backgroundColor = .white
                
                context.completeTransition(true)
            }
        }
    }
    
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1.5
    }
}
