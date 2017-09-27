//
//  ProfileToImageProdileTransition.swift
//  AllStarsV2
//
//  Created by Javier Siancas Fajardo on 9/27/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ProfileToImageProfileInteractiveTransition: InteractiveTransition {
    var initialScale: CGFloat = 0
    
    @objc func gestureTransitionMethod(_ gesture : UIPanGestureRecognizer){
        let view = self.navigationController.view!
        
        if gesture.state == .began {
            self.interactiveTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController.popViewController(animated: true)
        }
        else if gesture.state == .changed {
            let translation = gesture.translation(in: view)
            let delta = fabs(translation.x / view.bounds.width)
            self.interactiveTransition?.update(delta)
        }
        else {
            self.interactiveTransition?.finish()
            self.interactiveTransition = nil
        }
    }
}

class ProfileToImageProfileTransition: ControllerTransition {

    override func createInteractiveTransition(navigationController: UINavigationController) -> InteractiveTransition? {
        
        let interactiveTransition = ProfileToImageProfileInteractiveTransition()
        interactiveTransition.navigationController = navigationController
        interactiveTransition.gestureTransition = UIPanGestureRecognizer(target: interactiveTransition, action: #selector(interactiveTransition.gestureTransitionMethod(_:)))
        interactiveTransition.navigationController.view.addGestureRecognizer(interactiveTransition.gestureTransition!)
        
        return interactiveTransition
    }
    
    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        let profileViewController = self.controllerOrigin as! UserProfileViewController
        let imageProfileViewController = self.controllerDestination as! ImageProfileViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        let toView = context.view(forKey: .to)!
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        let imageViewFrame = profileViewController.imgUser!.convert(profileViewController.imgUser!.frame, to: profileViewController.view)
        print(imageViewFrame)
        
        imageProfileViewController.userProfileImageViewTopConstraint.constant       = 79.0 - 15.0//imageViewFrame.origin.y
        imageProfileViewController.userProfileImageViewLeadingConstraint.constant   = 8.0//imageViewFrame.origin.x
        imageProfileViewController.userProfileImageViewWidthConstraint.constant     = imageViewFrame.width
        imageProfileViewController.userProfileImageViewHeightConstraint.constant    = imageViewFrame.height
        imageProfileViewController.view.layoutIfNeeded()
        
        imageProfileViewController.view.backgroundColor                 = .clear
        imageProfileViewController.imgUser.layer.cornerRadius           = (imageViewFrame.width / 2.0)
        imageProfileViewController.imgUser.layer.masksToBounds          = true
        imageProfileViewController.userProfileImageBackgroundView.alpha = 0.0

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
                        
            imageProfileViewController.view.backgroundColor         = .white
            imageProfileViewController.imgUser.layer.cornerRadius   = 0.0
                
            imageProfileViewController.userProfileImageViewTopConstraint.constant       = 0.0
            imageProfileViewController.userProfileImageViewLeadingConstraint.constant   = 0.0
            imageProfileViewController.userProfileImageViewWidthConstraint.constant     = UIScreen.main.bounds.width
            imageProfileViewController.userProfileImageViewHeightConstraint.constant    = UIScreen.main.bounds.height
                        
            imageProfileViewController.view.layoutIfNeeded()
                        
        }, completion: { (_) in
            context.completeTransition(true)
        })
    }
    
    override func animatePop(toContext context : UIViewControllerContextTransitioning) {
        let imageProfileViewController = self.controllerOrigin as! ImageProfileViewController
        let profileViewController = self.controllerDestination as! UserProfileViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let toView = context.view(forKey: .to)!
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        let fromView = context.view(forKey: .from)!
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        let imageViewFrame = profileViewController.imgUser!.convert(profileViewController.imgUser!.frame, to: profileViewController.view)
        print(imageViewFrame)
        
        imageProfileViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
                        
            imageProfileViewController.view.backgroundColor         = .clear
            imageProfileViewController.imgUser.layer.cornerRadius   = (imageViewFrame.width / 2.0)
                        
            imageProfileViewController.userProfileImageViewTopConstraint.constant       = 79.0 - 15.0//imageViewFrame.origin.y
            imageProfileViewController.userProfileImageViewLeadingConstraint.constant   = 8.0//imageViewFrame.origin.x
            imageProfileViewController.userProfileImageViewWidthConstraint.constant     = imageViewFrame.width
            imageProfileViewController.userProfileImageViewHeightConstraint.constant    = imageViewFrame.height
                        
            imageProfileViewController.view.layoutIfNeeded()
                        
        }, completion: { (_) in
            context.completeTransition(true)
        })
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}
