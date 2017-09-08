//
//  AnimationManager.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 24/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AnimationTransitionManager: NSObject, UINavigationControllerDelegate {

    @IBOutlet weak var navigationController : UINavigationController!{
        didSet{
            self.navigationController.view.addGestureRecognizer(self.panGesture)
        }
    }
    
    var interactionController : UIPercentDrivenInteractiveTransition?
    var transitionController  : ControllerTransition!
    
    
    lazy var panGesture : UIPanGestureRecognizer = {
        
        let _panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRecognizer(_:)))
        return _panGesture
    }()
    
    
    @objc func panGestureRecognizer(_ gesture : UIPanGestureRecognizer){
        
        let view = self.navigationController.view!
        
        if gesture.state == .began {
            
            self.interactionController = UIPercentDrivenInteractiveTransition()
            self.navigationController.popViewController(animated: true)
            
        }else if gesture.state == .changed{
            
            let translation = gesture.translation(in: view)
            let delta = fabs(translation.x / view.bounds.width)
            print(delta)
            self.interactionController?.update(delta)
            
        }else{
            self.interactionController?.finish()
            self.interactionController = nil
            
        }
    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        self.transitionController = AnimationTransitionFactory.getAnimationTransitionTo(controllerOrigin: fromVC, withDestinationController: toVC, withOperation: operation)
        return self.transitionController
    }
    
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return self.interactionController
    }
    
}
