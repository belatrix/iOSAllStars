//
//  EventsToSeeAllEventsTransition.swift
//  AllStarsV2
//
//  Created by Javier Siancas Fajardo on 9/26/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EventsToSeeAllEventsInteractiveTransition: InteractiveTransition {
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

class EventsToSeeAllEventsTransition: ControllerTransition {

    override func createInteractiveTransition(navigationController: UINavigationController) -> InteractiveTransition? {
        
        let interactiveTransition = EventsToSeeAllEventsInteractiveTransition()
        interactiveTransition.navigationController = navigationController
        interactiveTransition.gestureTransition = UIPanGestureRecognizer(target: interactiveTransition, action: #selector(interactiveTransition.gestureTransitionMethod(_:)))
        interactiveTransition.navigationController.view.addGestureRecognizer(interactiveTransition.gestureTransition!)
        
        return interactiveTransition
    }
    
    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        let eventsViewController = self.controllerOrigin as! EventsViewController
        let seeAllEventsViewController = self.controllerDestination as! SeeAllEventsCategoryViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        let toView = context.view(forKey: .to)!
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        seeAllEventsViewController.view.backgroundColor = .clear
        seeAllEventsViewController.seeAllEventsTableViewCenterXConstraint.constant  = UIScreen.main.bounds.width
        seeAllEventsViewController.view.layoutIfNeeded()
        
        eventsViewController.headerView.alpha       = 0.0
        seeAllEventsViewController.headerView.alpha = 1.0
        
        UIView.animate(withDuration: 0.65,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseOut,
                       animations: {
                        
            seeAllEventsViewController.seeAllEventsTableViewCenterXConstraint.constant  = 0.0
            eventsViewController.eventsCategoriesScrollViewCenterXConstraint.constant   = (-1.0 * UIScreen.main.bounds.width)
                        
            seeAllEventsViewController.view.layoutIfNeeded()
            eventsViewController.view.layoutIfNeeded()
                        
        }, completion: { (_) in
            seeAllEventsViewController.view.backgroundColor = .white
            
            context.completeTransition(true)
        })
    }
    
    override func animatePop(toContext context : UIViewControllerContextTransitioning) {
        let seeAllEventsViewController = self.controllerOrigin as! SeeAllEventsCategoryViewController
        let eventsViewController = self.controllerDestination as! EventsViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        let toView = context.view(forKey: .to)!
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        eventsViewController.view.backgroundColor = .clear
        
        eventsViewController.headerView.alpha       = 1.0
        seeAllEventsViewController.headerView.alpha = 0.0
        
        UIView.animate(withDuration: 0.65,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseOut,
                       animations: {
            
            eventsViewController.eventsCategoriesScrollViewCenterXConstraint.constant   = 0.0
            seeAllEventsViewController.seeAllEventsTableViewCenterXConstraint.constant  = UIScreen.main.bounds.width
                        
            seeAllEventsViewController.view.layoutIfNeeded()
            eventsViewController.view.layoutIfNeeded()
                        
        }, completion: { (_) in
            eventsViewController.view.backgroundColor = .white
            
            context.completeTransition(true)
        })
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.65
    }
}
