//
//  CategoryToDetailTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 14/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class CategoryToDetailTransition: ControllerTransition {
    
    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! UserProfileViewController
        let toVC   = self.controllerDestination as! CategoryDetailViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        let cell = fromVC.controllerCategories.categoryCellSelected
        let frameRelativeCell = fromVC.controllerCategories.tlbCategories.convert(cell!.frame, to: containerView)
        print(frameRelativeCell.origin.y)
        
        cell?.alpha = 0
        toVC.constraintTopHeader.constant = frameRelativeCell.origin.y
        toVC.constraintTopTitle.constant = 16
        toVC.constraintBottomTitle.constant = 15.5
        toVC.constraintMiddleTitle.constant = -((UIScreen.main.bounds.size.width - cell!.lblName.frame.size.width)/2 - 8)
        toVC.constraintHeightHeader.constant = frameRelativeCell.height
        toVC.btnBack.alpha = 0
        toVC.viewHeader.backgroundColor = .clear
        toVC.lblTitle.font = cell?.fontTitleInitial
        toVC.lblTitle.textColor = cell?.titleColorInitial
        toVC.lblTitle.text = cell?.lblName.text
        toVC.constraintTopContent.constant = UIScreen.main.bounds.size.height
        toView.backgroundColor = .clear
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration * 0.1, animations: {
            
            toVC.viewHeader.backgroundColor = Constants.MAIN_COLOR
            toVC.lblTitle.textColor = toVC.titleColorInitial
            
        }) { (_) in
            
            UIView.animate(withDuration: duration * 0.35, animations: {
                
                toVC.constraintTopHeader.constant = 0
                toVC.constraintTopTitle.constant = 20
                toVC.constraintBottomTitle.constant = 0
                toVC.constraintMiddleTitle.constant = 0
                toVC.constraintHeightHeader.constant = 64
                toVC.btnBack.alpha = 1
                
                containerView.layoutIfNeeded()
                
            }) { (_) in
                
                toVC.lblTitle.font = toVC.fontTitleInitial
            }
            
        }
        
        UIView.animate(withDuration: duration * 0.5, delay: duration * 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            toVC.constraintTopContent.constant = 64
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            cell?.alpha = 1
            context.completeTransition(true)
        }
        
    }
    
    override func animatePop(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! CategoryDetailViewController
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
        
        let cell = toVC.controllerCategories.categoryCellSelected
        let frameRelativeCell = toVC.controllerCategories.tlbCategories.convert(cell!.frame, to: toView)
        
        cell?.alpha = 0
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration * 0.35, animations: {
            
            fromVC.constraintTopHeader.constant = frameRelativeCell.origin.y
            fromVC.constraintTopContent.constant = UIScreen.main.bounds.size.height
            fromVC.constraintTopTitle.constant = 16
            fromVC.constraintBottomTitle.constant = 15.5
            fromVC.constraintMiddleTitle.constant = -((UIScreen.main.bounds.size.width - cell!.lblName.frame.size.width)/2 - 8)
            fromVC.constraintHeightHeader.constant = frameRelativeCell.height
            fromVC.btnBack.alpha = 0
            fromVC.lblTitle.font = cell?.fontTitleInitial
            
            containerView.layoutIfNeeded()
            
        }) { (_) in
            
            UIView.animate(withDuration: duration * 0.5, animations: {
                
                fromVC.lblTitle.textColor = cell?.titleColorInitial
                fromVC.viewHeader.backgroundColor = .clear
                fromView.alpha = 0
                cell?.alpha = 1
                
                containerView.layoutIfNeeded()
                
            }) { (_) in
                
                context.completeTransition(true)
            }
            
        }
        
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1
    }
}
