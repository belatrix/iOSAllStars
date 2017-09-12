//
//  LoginPasswordTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 24/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class LoginPasswordInteractiveTransition : InteractiveTransition{
    
    var initialScale : CGFloat = 0
    
//    @objc func gestureTransitionMethod(_ gesture : UIPanGestureRecognizer){
//
//        let view = self.navigationController.view!
//
//        if gesture.state == .began {
//
//            self.interactiveTransition = UIPercentDrivenInteractiveTransition()
//            self.navigationController.popViewController(animated: true)
//
//        }else if gesture.state == .changed{
//
//            let translation = gesture.translation(in: view)
//            let delta = fabs(translation.x / view.bounds.width)
//            print(delta)
//            self.interactiveTransition?.update(delta)
//
//        }else{
//            print("else")
//
//            self.interactiveTransition?.finish()
//            self.interactiveTransition = nil
//
//        }
//    }
    
    @objc func gestureTransitionMethod(_ gesture : UIPinchGestureRecognizer){
        
        var delta = fabs((gesture.scale - initialScale) / 8)
        
        if gesture.state == .began {
            
            self.interactiveTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController.popViewController(animated: true)
            self.initialScale = gesture.scale
            
        }else if gesture.state == .changed{
            
            delta = delta > 1.0 ? 1 : delta
            self.interactiveTransition?.update(delta)

        }else{
            self.interactiveTransition?.finish()
            self.interactiveTransition = nil
        }

    }
}

class LoginPasswordTransition: ControllerTransition {

    
    
    override func createInteractiveTransition(navigationController: UINavigationController) -> InteractiveTransition? {
        
        let interactiveTransition = LoginPasswordInteractiveTransition()
        interactiveTransition.navigationController = navigationController
        interactiveTransition.gestureTransition = UIPinchGestureRecognizer(target: interactiveTransition, action: #selector(interactiveTransition.gestureTransitionMethod(_:)))
        interactiveTransition.navigationController.view.addGestureRecognizer(interactiveTransition.gestureTransition!)
        
        return interactiveTransition
    }
    
    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! LoginViewController
        let toVC   = self.controllerDestination as! ForgotPasswordViewController
        
        let containerView = context.containerView
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toVC.constraintCenterForm.constant = (UIScreen.main.bounds.size.height + toVC.viewFormUser.bounds.size.height) / 2
        toVC.constraintBottomViewLogo.constant = UIScreen.main.bounds.size.height
        toVC.constraintTopViewLogo.constant = -(UIScreen.main.bounds.size.height + toVC.viewLogo.frame.size.height)
        
        containerView.layoutIfNeeded()
    
        UIView.animate(withDuration: 0.5, animations: {
            
            fromVC.constraintCenterForm.constant = (UIScreen.main.bounds.size.height + fromVC.viewFormUser.bounds.size.height) / 2
            fromVC.constraintBottomViewLogo.constant = UIScreen.main.bounds.size.height
            fromVC.constraintTopViewLogo.constant = -(UIScreen.main.bounds.size.height + fromVC.viewLogo.frame.size.height)
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            fromView.backgroundColor = .clear
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                
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
        
        let fromVC = self.controllerOrigin as! ForgotPasswordViewController
        let toVC   = self.controllerDestination as! LoginViewController
        
        let containerView = context.containerView
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
//        let duration = self.transitionDuration(using: context)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toVC.constraintCenterForm.constant = (UIScreen.main.bounds.size.height + toVC.viewFormUser.bounds.size.height) / 2
        toVC.constraintBottomViewLogo.constant = UIScreen.main.bounds.size.height
        toVC.constraintTopViewLogo.constant = -(UIScreen.main.bounds.size.height + toVC.viewLogo.frame.size.height)
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, animations: {
            
            fromVC.constraintCenterForm.constant = (UIScreen.main.bounds.size.height + fromVC.viewFormUser.bounds.size.height) / 2
            fromVC.constraintBottomViewLogo.constant = UIScreen.main.bounds.size.height
            fromVC.constraintTopViewLogo.constant = -(UIScreen.main.bounds.size.height + fromVC.viewLogo.frame.size.height)
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            fromView.backgroundColor = .clear
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                
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
        
        return 0.5
    }
}
