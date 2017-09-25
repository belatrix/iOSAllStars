//
//  ProfileToKudosTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 25/09/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ProfileToKudosTransition: ControllerTransition {

    override func animatePush(toContext context : UIViewControllerContextTransitioning){
        
        let fromVC = self.controllerOrigin as! UserProfileViewController
        let toVC   = self.controllerDestination as! KudosUserViewController
    
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
    
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toVC.viewUserInformation.alpha = 0
        let delta = UIScreen.main.bounds.size.height - toVC.viewOptions.frame.origin.y
        toVC.constraintTopOptions.constant = delta
        toVC.constraintBottonOptions.constant = delta
        toVC.viewOptions.alpha = 0
        toVC.lblUserName.alpha = 0
        toVC.lblUserLevel.alpha = 0
        toVC.viewHeader.alpha = 0
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, animations: {
            
            fromVC.viewContainerInfo.backgroundColor = .white
            fromVC.constraintTopSections.constant = UIScreen.main.bounds.size.height
            fromVC.constraintBottomSections.constant = UIScreen.main.bounds.size.height
            fromVC.constraintHeightData.constant = 120
            fromVC.imgUser?.layer.cornerRadius = 45
            fromVC.imgUser?.borderImage = 0
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            fromVC.viewContainerInfo.alpha = 0
            fromView.backgroundColor = .clear
            toVC.viewUserInformation.alpha = 1
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                
                fromVC.viewHeader.alpha = 0
                toVC.viewHeader.alpha = 1
                toVC.constraintTopOptions.constant = 0
                toVC.constraintBottonOptions.constant = 0
                toVC.viewOptions.alpha = 1
                toVC.lblUserName.alpha = 1
                toVC.lblUserLevel.alpha = 1
                
                containerView.layoutIfNeeded()
                
            }) { (_) in
                
                context.completeTransition(true)
            }

        }
        
    }
    
    
    
    override func animatePop(toContext context : UIViewControllerContextTransitioning) {

        let fromVC = self.controllerOrigin as! KudosUserViewController
        let toVC   = self.controllerDestination as! UserProfileViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        containerView.layoutIfNeeded()
        
        let delta = UIScreen.main.bounds.size.height - fromVC.viewOptions.frame.origin.y
        
        UIView.animate(withDuration: 0.4, animations: {
            
            fromVC.constraintTopOptions.constant = delta
            fromVC.constraintBottonOptions.constant = delta
            fromVC.viewOptions.alpha = 0
            fromVC.constraintHeightData.constant = 170
            toVC.constraintHeightData.constant = 170
            fromVC.imgUser.layer.cornerRadius = 70
            toVC.imgUser?.layer.cornerRadius = 70
            fromVC.imgUser.borderImage = 5
            toVC.imgUser?.borderImage = 5
            fromVC.lblUserName.alpha = 0
            fromVC.lblUserLevel.alpha = 0
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            toView.backgroundColor = .white
            fromView.backgroundColor = .clear
            fromVC.viewUserInformation.alpha = 0
            toVC.viewContainerInfo.alpha = 1
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                
                fromVC.viewHeader.alpha = 0
                toVC.viewHeader.alpha = 1
                toVC.viewContainerInfo.backgroundColor = CDMColorManager.colorFromHexString("F89937", withAlpha: 1)
                toVC.constraintTopSections.constant = 0
                toVC.constraintBottomSections.constant = 0
                
                containerView.layoutIfNeeded()
                
            }) { (_) in
                
                context.completeTransition(true)
            }

        }
        
    }
    
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.9
    }
}
