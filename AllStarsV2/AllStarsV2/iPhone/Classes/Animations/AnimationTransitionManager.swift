//
//  AnimationManager.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 24/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit


class AnimationTransitionManager: NSObject, UINavigationControllerDelegate {

    var interactiveTransition : InteractiveTransition?
    
    @IBOutlet weak var navigationController : UINavigationController!

    var transitionController  : ControllerTransition!
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        let transitions = AnimationTransitionFactory.getAnimationTransitionTo(controllerOrigin: fromVC, withDestinationController: toVC, withOperation: operation, withNavigationController: self.navigationController)
        self.transitionController = transitions.transition
        
        if operation == .push{
            self.interactiveTransition = transitions.interactiveTransition
        }
    
        return self.transitionController
    }
    
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return self.interactiveTransition?.interactiveTransition
    }
    
}
