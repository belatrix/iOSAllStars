//
//  ControllerTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 24/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var controllerOrigin        : UIViewController?
    var controllerDestination   : UIViewController?
    
    var transitionMode : UINavigationControllerOperation = .push
    
    init(withOrigin origin: UIViewController, withDestination destination: UIViewController, withOperation operation: UINavigationControllerOperation) {
        
        self.controllerOrigin = origin
        self.controllerDestination = destination
        self.transitionMode = operation
    }
    
    
    func animatePush(toContext context : UIViewControllerContextTransitioning) {
    
    }
    
    func animatePop(toContext context : UIViewControllerContextTransitioning) {
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch self.transitionMode {
        case .push:
            
            self.animatePush(toContext: transitionContext)
            
        case .pop:
            
            self.animatePop(toContext: transitionContext)
            
        default : break
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0
    }
    
    func createInteractiveTransition(navigationController : UINavigationController) -> InteractiveTransition?{
        
        return nil
    }
}
