//
//  ContactsToProfileTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 21/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ContactsToProfileTransition: ControllerTransition {

    override func animatePush(toContext context : UIViewControllerContextTransitioning){
        
        let fromVC = self.controllerOrigin as! ContactsViewController
        let toVC   = self.controllerDestination as! UserProfileViewController
        let cellSelected = fromVC.cellSelected!
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
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
        
        imgUser.animateBordeWidthFromValue(imgUser.borderImage, toValue: 5 / delta)
        
        
        
        toVC.constraintTopHeader.constant = -64
        toVC.imgUser!.alpha = 0
        toVC.viewContainerInfo.alpha = 0
        toVC.constraintTopSections.constant = UIScreen.main.bounds.size.height
        toVC.constraintBottomSections.constant = UIScreen.main.bounds.size.height
        toView.backgroundColor = .clear
        
        cellSelected.imgUser.alpha = 0
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration * 0.15, animations: {
            
            fromView.alpha = 0
            
        }) { (_) in
            
            toView.backgroundColor = .white
            
            UIView.animate(withDuration: duration * 0.15, animations: {
                
                toVC.constraintTopHeader.constant = 0
                containerView.layoutIfNeeded()
                
            }, completion: { (_) in
                
                UIView.animate(withDuration: duration * 0.15, animations: {
                    
                    toVC.viewContainerInfo.alpha = 1
                    containerView.layoutIfNeeded()
                    
                }, completion: { (_) in
                    
                    UIView.animate(withDuration: duration * 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                        
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
        
        
        UIView.animate(withDuration: duration * 0.5, delay: duration * 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            imgUser.transform = CGAffineTransform(scaleX: delta, y: delta)
            imgUser.center = newCenter
            
        }) { (_) in
            
            imgUser.removeFromSuperview()
            toVC.imgUser!.alpha = 1
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
        fromView.backgroundColor = .clear
        toView.alpha = 0
        
        cellSelected.imgUser.alpha = 0
        
        let delta = cellSelected.imgUser.frame.size.height / 140
        
        UIView.animate(withDuration: duration * 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            fromVC.constraintTopSections.constant = UIScreen.main.bounds.size.height
            fromVC.constraintBottomSections.constant = UIScreen.main.bounds.size.height
            fromVC.viewContainerInfo.alpha = 0
            fromVC.constraintTopHeader.constant = -64
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
        }
        
        imgUser.animateBordeWidthFromValue(5, toValue: 0)
        
        UIView.animate(withDuration: duration * 0.65, delay: duration * 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            toView.alpha = 1
            
            imgUser.transform = CGAffineTransform(scaleX: delta, y: delta)
            var relativeFrame = toVC.clvContacts.convert(cellSelected.frame, to: containerView)
            relativeFrame.origin.x = relativeFrame.origin.x + cellSelected.imgUser.frame.origin.x
            relativeFrame.origin.y = relativeFrame.origin.y + cellSelected.imgUser.frame.origin.y
            imgUser.center = CGPoint(x: relativeFrame.origin.x + cellSelected.imgUser.frame.size.width / 2, y: relativeFrame.origin.y + cellSelected.imgUser.frame.size.height / 2)
            
        }) { (_) in
            
            imgUser.removeFromSuperview()
            cellSelected.imgUser.alpha = 1
            context.completeTransition(true)
        }
        
    }
    
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1.3
    }
}
