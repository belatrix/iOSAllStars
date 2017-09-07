//
//  AnimationManager.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 24/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AnimationTransitionManager: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        let transitionController = AnimationTransitionFactory.getAnimationTransitionTo(controllerOrigin: fromVC, withDestinationController: toVC, withOperation: operation)
        return transitionController
    }
    
}
