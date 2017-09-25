//
//  ContactsToProfileTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 21/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ContactsToProfileInteractiveTransition : InteractiveTransition{
    
    var initialScale : CGFloat = 0
    
    @objc func gestureTransitionMethod(_ gesture : UIPanGestureRecognizer){
        
        let view = self.navigationController.view!
        
        if gesture.state == .began {
            
            self.interactiveTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController.popViewController(animated: true)
            
        }else if gesture.state == .changed{
            
            let translation = gesture.translation(in: view)
            let delta = fabs(translation.x / view.bounds.width)
            self.interactiveTransition?.update(delta)
            
        }else{
            
            self.interactiveTransition?.finish()
            self.interactiveTransition = nil
            
        }
    }
}


class ContactsToProfileTransition: ControllerTransition {

    override func createInteractiveTransition(navigationController: UINavigationController) -> InteractiveTransition? {
        
        let interactiveTransition = ContactsToProfileInteractiveTransition()
        interactiveTransition.navigationController = navigationController
        interactiveTransition.gestureTransition = UIPanGestureRecognizer(target: interactiveTransition, action: #selector(interactiveTransition.gestureTransitionMethod(_:)))
        interactiveTransition.navigationController.view.addGestureRecognizer(interactiveTransition.gestureTransition!)
        
        return interactiveTransition
    }
    
    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! ContactsViewController
        let toVC   = self.controllerDestination as! UserProfileViewController
        let cellSelected = fromVC.cellSelected!
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        
        let imgUser = ImageUserProfile()
        let relativeFrame = fromVC.clvContacts.convert(cellSelected.frame, to: containerView)
        imgUser.frame.origin.x = relativeFrame.origin.x + cellSelected.imgUser.frame.origin.x
        imgUser.frame.origin.y = relativeFrame.origin.y + cellSelected.imgUser.frame.origin.y
        imgUser.frame.size = cellSelected.imgUser.frame.size
        imgUser.objUser = cellSelected.objContact
        containerView.addSubview(imgUser)
        imgUser.image = cellSelected.imgUser.imgUser.image

        let newCenter = CGPoint(x: 78, y: 149)
        let delta = 140 / cellSelected.imgUser.frame.size.height
        
        imgUser.setInitialVisualConfiguration()
        
        toVC.constraintTopHeader.constant = -64
        toVC.imgUser!.alpha = 0
        toVC.viewContainerInfo.alpha = 0
        toVC.constraintTopSections.constant = UIScreen.main.bounds.size.height
        toVC.constraintBottomSections.constant = UIScreen.main.bounds.size.height
        toView.backgroundColor = .clear
        
        cellSelected.imgUser.alpha = 0
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.2, animations: {
            
            fromView.alpha = 0
            
        }) { (_) in
            
            toView.backgroundColor = .white
            
            UIView.animate(withDuration: 0.2, animations: {
                
                toVC.constraintTopHeader.constant = 0
                containerView.layoutIfNeeded()
                
            }, completion: { (_) in
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    toVC.viewContainerInfo.alpha = 1
                    containerView.layoutIfNeeded()
                    
                }, completion: { (_) in
                    
                    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                        
                        toVC.constraintTopSections.constant = 0
                        toVC.constraintBottomSections.constant = 0
                        
                        containerView.layoutIfNeeded()
                        
                    }) { (_) in
                        
                        fromView.alpha = 1
                        cellSelected.imgUser.alpha = 1
                        context.completeTransition(true)
                    }
                    
                })
                
            })
            
        }
        
        
        UIView.animate(withDuration: 0.6, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            imgUser.animateBordeWidthFromValue(imgUser.borderImage, toValue: 5 / delta)
            imgUser.transform = CGAffineTransform(scaleX: delta, y: delta)
            imgUser.center = newCenter
            
        }) { (_) in
            
            imgUser.alpha = 0
            toVC.imgUser!.alpha = 1
            imgUser.removeFromSuperview()
            
        }
        
    }
    
    
    
    override func animatePop(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! UserProfileViewController
        let toVC   = self.controllerDestination as! ContactsViewController
        let cellSelected = toVC.cellSelected!
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        let imgUser = ImageUserProfile()
        imgUser.frame = CGRect(x: 8, y: 79, width: 140, height: 140)
        imgUser.objUser = fromVC.objUser
        imgUser.setInitialVisualConfiguration()
        imgUser.image = cellSelected.imgUser.imgUser.image
        containerView.addSubview(imgUser)
        imgUser.borderImage = 5
        
        
        fromVC.imgUser!.alpha = 0
        toView.alpha = 1
        
        cellSelected.imgUser.alpha = 0
        
        let delta = cellSelected.imgUser.frame.size.height / 140
        

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            fromVC.constraintTopSections.constant = UIScreen.main.bounds.size.height
            fromVC.constraintBottomSections.constant = UIScreen.main.bounds.size.height
            fromVC.viewContainerInfo.alpha = 0
            fromVC.constraintTopHeader.constant = -64
            
            fromView.backgroundColor = .clear
            
            imgUser.animateBordeWidthFromValue(5, toValue: 0)
            
            imgUser.transform = CGAffineTransform(scaleX: delta, y: delta)
            var relativeFrame = toVC.clvContacts.convert(cellSelected.frame, to: containerView)
            relativeFrame.origin.x = relativeFrame.origin.x + cellSelected.imgUser.frame.origin.x
            relativeFrame.origin.y = relativeFrame.origin.y + cellSelected.imgUser.frame.origin.y
            imgUser.center = CGPoint(x: relativeFrame.origin.x + cellSelected.imgUser.frame.size.width / 2, y: relativeFrame.origin.y + cellSelected.imgUser.frame.size.height / 2)
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            imgUser.alpha = 0
            cellSelected.imgUser.alpha = 1
            imgUser.removeFromSuperview()
            context.completeTransition(true)
        }
        
    }
    
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.9
    }
}
