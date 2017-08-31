//
//  LoginTabBarTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 3/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class LoginTabBarTransition: ControllerTransition {

    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        
        let containerView = context.containerView
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        

        containerView.layoutIfNeeded()
        
        toView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        fromView.layer.cornerRadius = 10
        fromView.layer.shadowRadius = 4
        fromView.layer.shadowOffset = CGSize(width: 0, height: 0)
        fromView.layer.masksToBounds = false
        fromView.layer.shadowOpacity = 0.5
        
        
        UIView.animate(withDuration: duration * 0.35, animations: {
        
            toView.transform = CGAffineTransform(scaleX: 1, y: 1)
            fromView.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)

            containerView.layoutIfNeeded()
            
        }) { (_) in
            

            UIView.animate(withDuration: duration * 0.65, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                
                
                fromView.transform = fromView.transform.translatedBy(x: 0, y: UIScreen.main.bounds.size.height + UIScreen.main.bounds.size.height/4)
                
                containerView.layoutIfNeeded()
                
            }) { (_) in
                
                fromView.transform = CGAffineTransform(scaleX: 1, y: 1).translatedBy(x: 0, y: 0)
                context.completeTransition(true)
            }
        }
        
    }
        
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1
    }
}
