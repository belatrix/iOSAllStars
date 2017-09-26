//
//  SeeAllEventsToEventDetailControllerTransition.swift
//  AllStarsV2
//
//  Created by Javier Siancas Fajardo on 9/26/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class SeeAllEventsToEventDetailInteractiveTransition : InteractiveTransition {
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

class SeeAllEventsToEventDetailTransition: ControllerTransition {

    override func createInteractiveTransition(navigationController: UINavigationController) -> InteractiveTransition? {
        
        let interactiveTransition = SeeAllEventsToEventDetailInteractiveTransition()
        interactiveTransition.navigationController = navigationController
        interactiveTransition.gestureTransition = UIPanGestureRecognizer(target: interactiveTransition, action: #selector(interactiveTransition.gestureTransitionMethod(_:)))
        interactiveTransition.navigationController.view.addGestureRecognizer(interactiveTransition.gestureTransition!)
        
        return interactiveTransition
    }
    
    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        let seeAllEventsViewController = self.controllerOrigin as! SeeAllEventsCategoryViewController
        let eventDetailViewController = self.controllerDestination as! EventDetailViewController
        let frameForEventImageViewSelected = seeAllEventsViewController.frameForEventImageViewSelected
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        let toView = context.view(forKey: .to)!
        toView.frame = UIScreen.main.bounds
        toView.backgroundColor = .clear
        containerView.addSubview(toView)
        
        eventDetailViewController.eventInformationView.alpha                    = 0.0
        eventDetailViewController.eventInformationBackgroundView.alpha          = 0.0
        eventDetailViewController.buttonsSectionView.alpha                      = 0.0
        eventDetailViewController.scrollContent.alpha                           = 0.0
        eventDetailViewController.imgEvent.layer.cornerRadius                   = 8.0
        eventDetailViewController.eventInformationBackgroundView.layer.cornerRadius = 8.0
        eventDetailViewController.buttonsSectionsViewTopConstraint.constant     = 50.0
        eventDetailViewController.eventTitleLabelTopConstraint.constant         = 58.0
        eventDetailViewController.backgroundImageViewLeadingConstraint.constant = frameForEventImageViewSelected!.origin.x
        eventDetailViewController.backgroundImageViewTopConstraint.constant     = frameForEventImageViewSelected!.origin.y
        eventDetailViewController.backgroundImageViewWidthConstraint.constant   = frameForEventImageViewSelected!.width
        eventDetailViewController.backgroundImageViewHeightConstraint.constant  = frameForEventImageViewSelected!.height
        containerView.layoutIfNeeded()
        
        eventDetailViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
                        
            fromView.alpha = 0.0
            toView.backgroundColor = .white
                        
            eventDetailViewController.eventInformationBackgroundView.layer.cornerRadius = 0.0
            eventDetailViewController.imgEvent.layer.cornerRadius                       = 0.0
            eventDetailViewController.backgroundImageViewLeadingConstraint.constant     = 0.0
            eventDetailViewController.backgroundImageViewTopConstraint.constant         = 0.0
            eventDetailViewController.backgroundImageViewWidthConstraint.constant       = UIScreen.main.bounds.width
            eventDetailViewController.backgroundImageViewHeightConstraint.constant      = 180.0
                        
            eventDetailViewController.view.layoutIfNeeded()
                        
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
                        
            eventDetailViewController.headerView.alpha                              = 1.0
            eventDetailViewController.eventInformationBackgroundView.alpha          = 1.0
            eventDetailViewController.buttonsSectionsViewTopConstraint.constant     = 0.0
            eventDetailViewController.eventTitleLabelTopConstraint.constant         = 8.0
                        
            eventDetailViewController.view.layoutIfNeeded()
                        
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
            
            eventDetailViewController.eventInformationView.alpha    = 1.0
            eventDetailViewController.buttonsSectionView.alpha      = 1.0
            eventDetailViewController.scrollContent.alpha           = 1.0
            
        }) { (_) in
            context.completeTransition(true)
        }
        
    }
    
    override func animatePop(toContext context : UIViewControllerContextTransitioning) {
        let eventDetailViewController = self.controllerOrigin as! EventDetailViewController
        let eventsViewController = self.controllerDestination as! SeeAllEventsCategoryViewController
        let frameForEventImageViewSelected = eventsViewController.frameForEventImageViewSelected
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let toView = context.view(forKey: .to)!
        toView.frame = UIScreen.main.bounds
        toView.backgroundColor = .white
        toView.alpha = 1.0
        containerView.addSubview(toView)
        
        let fromView = context.view(forKey: .from)!
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        eventDetailViewController.eventInformationView.alpha    = 0.0
        eventDetailViewController.buttonsSectionView.alpha      = 0.0
        eventDetailViewController.scrollContent.alpha           = 0.0
        eventDetailViewController.imgEvent.layer.cornerRadius   = 8.0
        eventDetailViewController.eventInformationBackgroundView.layer.cornerRadius = 8.0
        eventDetailViewController.buttonsSectionsViewTopConstraint.constant     = 50.0
        eventDetailViewController.eventTitleLabelTopConstraint.constant         = 58.0
        
        eventDetailViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
                        
            fromView.backgroundColor = .clear
                        
            eventDetailViewController.eventInformationBackgroundView.alpha          = 0.0
            eventDetailViewController.backgroundImageViewLeadingConstraint.constant = frameForEventImageViewSelected!.origin.x
            eventDetailViewController.backgroundImageViewTopConstraint.constant     = frameForEventImageViewSelected!.origin.y
            eventDetailViewController.backgroundImageViewWidthConstraint.constant   = frameForEventImageViewSelected!.width
            eventDetailViewController.backgroundImageViewHeightConstraint.constant  = frameForEventImageViewSelected!.height
                        
            eventDetailViewController.view.layoutIfNeeded()
                        
        }, completion: { (_) in
            context.completeTransition(true)
        })
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
}
