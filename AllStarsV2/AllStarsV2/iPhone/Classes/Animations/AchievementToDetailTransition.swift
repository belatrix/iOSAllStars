//
//  AchievementToDetailTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 14/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AchievementToDetailInteractiveTransition : InteractiveTransition{
    
    var initialScale : CGFloat = 0
    
    @objc func gestureTransitionMethod(_ gesture : UIPanGestureRecognizer){
        
        let view = self.navigationController.view!
        
        if gesture.state == .began {
            
            self.interactiveTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController.popViewController(animated: true)
            
        }else if gesture.state == .changed{
            
            let translation = gesture.translation(in: view)
            let delta = fabs(translation.y / view.bounds.height)
            self.interactiveTransition?.update(delta)
            
        }else{
            
            self.interactiveTransition?.finish()
            self.interactiveTransition = nil
            
        }
    }
}


class AchievementToDetailTransition: ControllerTransition {

    override func createInteractiveTransition(navigationController: UINavigationController) -> InteractiveTransition? {
        
        let interactiveTransition = AchievementToDetailInteractiveTransition()
        interactiveTransition.navigationController = navigationController
        interactiveTransition.gestureTransition = UIPanGestureRecognizer(target: interactiveTransition, action: #selector(interactiveTransition.gestureTransitionMethod(_:)))
        interactiveTransition.navigationController.view.addGestureRecognizer(interactiveTransition.gestureTransition!)
        
        return interactiveTransition
    }
    
    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! UserProfileViewController
        let toVC   = self.controllerDestination as! AchievementDetailViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        let cell = fromVC.controllerAchievements.achievementCellSelected
        let cellFrame = fromVC.controllerAchievements.clvAchievements.convert(cell!.frame, to: containerView)
        let imageFrame = cell!.imgIcon.frame
        let imageIcon = UIImageView(image: cell!.imgIcon.image)
        containerView.addSubview(imageIcon)
        imageIcon.frame = CGRect(x: cellFrame.origin.x + imageFrame.origin.x , y: cellFrame.origin.y  + imageFrame.origin.y, width: imageFrame.width, height: imageFrame.height)
        cell!.imgIcon.alpha = 0
        
        toVC.constraintLeftBtnCerrar.constant = -44
        toVC.constraintTopContent.constant = UIScreen.main.bounds.size.height - toVC.viewContent.frame.origin.y + toVC.initialContraintTopContent
        toVC.constraintBottomShare.constant = -60
        toView.backgroundColor = .clear
        toVC.imgIcon.alpha = 0
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration*0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            imageIcon.frame = toVC.imgIcon.frame
            imageIcon.center.x = UIScreen.main.bounds.size.width / 2
            toView.backgroundColor = .white
            toVC.constraintLeftBtnCerrar.constant = 0
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            
        }
        
        UIView.animate(withDuration: duration*0.7, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            toVC.constraintTopContent.constant = toVC.initialContraintTopContent
            toVC.constraintBottomShare.constant = toVC.initialCOnstraintBottomShare
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            cell!.imgIcon.alpha = 1
            imageIcon.removeFromSuperview()
            toVC.imgIcon.alpha = 1
            context.completeTransition(true)
        }
        
    }
    
    override func animatePop(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! AchievementDetailViewController
        let toVC   = self.controllerDestination as! UserProfileViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        let imageIcon = UIImageView(image: fromVC.imgIcon.image)
        containerView.addSubview(imageIcon)
        imageIcon.frame = fromVC.imgIcon.frame
        
        fromVC.imgIcon.alpha = 0
        toVC.controllerAchievements.achievementCellSelected.imgIcon.alpha = 0
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            let cell = toVC.controllerAchievements.achievementCellSelected
            let cellFrame = toVC.controllerAchievements.clvAchievements.convert(cell!.frame, to: containerView)
            let imageFrame = cell!.imgIcon.frame
            imageIcon.frame = CGRect(x: cellFrame.origin.x + imageFrame.origin.x , y: cellFrame.origin.y  + imageFrame.origin.y, width: imageFrame.width, height: imageFrame.height)
            fromView.backgroundColor = .clear
            fromVC.constraintLeftBtnCerrar.constant = -44
            
            fromVC.viewContent.alpha = 0
            fromVC.constraintTopContent.constant = UIScreen.main.bounds.size.height - fromVC.viewContent.frame.origin.y + fromVC.initialContraintTopContent
            fromVC.constraintBottomShare.constant = -60
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            toVC.controllerAchievements.achievementCellSelected.imgIcon.alpha = 1
            imageIcon.removeFromSuperview()
            fromVC.imgIcon.alpha = 1
            context.completeTransition(true)
        }
        
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.8
    }
}
