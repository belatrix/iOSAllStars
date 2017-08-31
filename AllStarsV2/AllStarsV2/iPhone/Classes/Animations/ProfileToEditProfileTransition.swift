//
//  TabBarEditProfileTransition.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 15/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ProfileToEditProfileTransition: ControllerTransition {

    override func animatePush(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! UserProfileViewController
        let toVC   = self.controllerDestination as! EditProfileViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!
        
        let duration = self.transitionDuration(using: context)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)

        toVC.constraintTopScroll.constant = UIScreen.main.bounds.size.height
        toVC.constraintTopHeader.constant = -64
        toVC.viewPhotoContainer.alpha = 0
        toVC.constraintBottomScroll.constant = -UIScreen.main.bounds.size.height
        toVC.constraintBottomSave.constant = -44
        toVC.btnTakePhoto.alpha = 0
        toVC.btnTakePhoto.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        toVC.imgUser.alpha = 0
        toView.backgroundColor = .clear
        
        let imgUser = ImageUserProfile()
        imgUser.frame = fromVC.viewContainerInfo.convert(fromVC.imgUser!.frame, to: containerView)
        imgUser.objUser = fromVC.objUser!
        imgUser.setInitialVisualConfiguration()
        containerView.addSubview(imgUser)
        imgUser.image = fromVC.imgUser!.imgUser.image
        imgUser.borderImage = fromVC.imgUser!.borderImage
        
        fromVC.imgUser!.alpha = 0
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration * 0.65, delay: duration * 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {

            toVC.constraintTopScroll.constant = 0
            toVC.constraintBottomScroll.constant = 44

            let newFrame = toVC.imgUser.convert(toVC.imgUser.frame, to: toVC.view)
            let newCenter = toVC.imgUser.convert(toVC.imgUser.center, to: toVC.view)
            
            let delta = newFrame.size.height / imgUser.frame.size.height
            imgUser.transform = CGAffineTransform(scaleX: delta, y: delta)
            
            imgUser.center = newCenter

            containerView.layoutIfNeeded()

        }) { (_) in

        }


        UIView.animate(withDuration: duration * 0.25, animations: {

            fromVC.constraintTopHeader.constant = -64
            toView.backgroundColor = .white


            containerView.layoutIfNeeded()

        }) { (_) in

            UIView.animate(withDuration: duration * 0.25, animations: {

                toVC.constraintTopHeader.constant = 0
                containerView.layoutIfNeeded()

            }, completion: { (_) in

                UIView.animate(withDuration: duration * 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {

                    toVC.constraintBottomSave.constant = 0
                    toVC.viewPhotoContainer.alpha = 1
                    toVC.btnTakePhoto.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

                    containerView.layoutIfNeeded()

                }) { (_) in
                    
                    toVC.imgUser.alpha = 1
                    imgUser.removeFromSuperview()

                    UIView.animate(withDuration: duration * 0.2, animations: {

                        toVC.btnTakePhoto.alpha = 1
                        toVC.btnTakePhoto.transform = CGAffineTransform(scaleX: 1, y: 1)

                    }, completion: { (_) in

                        fromVC.imgUser?.alpha = 1
                        fromVC.constraintTopHeader.constant = 0
                        context.completeTransition(true)

                    })

                }

            })
        }

    }
    
    override func animatePop(toContext context : UIViewControllerContextTransitioning) {
        
        let fromVC = self.controllerOrigin as! EditProfileViewController
        let toVC   = self.controllerDestination as! UserProfileViewController
        
        let containerView = context.containerView
        containerView.backgroundColor = .white
        
        let duration = self.transitionDuration(using: context)
        
        let fromView = context.view(forKey: .from)!
        let toView = context.view(forKey: .to)!

        toView.frame = UIScreen.main.bounds
        containerView.addSubview(toView)
        
        fromView.frame = UIScreen.main.bounds
        containerView.addSubview(fromView)
        
        toVC.constraintTopHeader.constant = -64
        
        let imgUser = ImageUserProfile()
        imgUser.frame = fromVC.imgUser.convert(fromVC.imgUser.frame, to: containerView)
        imgUser.objUser = fromVC.objUser
        imgUser.setInitialVisualConfiguration()
        
        containerView.addSubview(imgUser)
        imgUser.alpha = 0
        imgUser.borderImage = toVC.imgUser!.borderImage
        
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration * 0.65, delay: duration * 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {

            let newFrame = toVC.imgUser!.convert(toVC.imgUser!.frame, to: toVC.view)
            let newCenter = toVC.imgUser!.convert(toVC.imgUser!.center, to: toVC.view)

            let delta = newFrame.size.height / imgUser.frame.size.height
            imgUser.transform = CGAffineTransform(scaleX: delta, y: delta)

            imgUser.center = newCenter
            imgUser.center.y = imgUser.center.y - 15
            imgUser.center.x = imgUser.center.x - 8

            containerView.layoutIfNeeded()

        }) { (_) in

            imgUser.removeFromSuperview()
            context.completeTransition(true)
        }
        
        UIView.animate(withDuration: duration * 0.2, animations: {
            
            fromVC.btnTakePhoto.alpha = 0
            fromVC.btnTakePhoto.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
        }, completion: { (_) in
    
            imgUser.alpha = 1
            
            UIView.animate(withDuration: duration * 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                
                fromVC.constraintBottomSave.constant = -44
                fromVC.constraintTopHeader.constant = -64
                fromVC.constraintTopScroll.constant = UIScreen.main.bounds.size.height
                fromVC.constraintBottomScroll.constant = -UIScreen.main.bounds.size.height
                
                fromVC.viewPhotoContainer.alpha = 0
                
                containerView.layoutIfNeeded()
                
            }) { (_) in
                
                UIView.animate(withDuration: duration * 0.25, animations: {
                    toVC.constraintTopHeader.constant = 0
                    fromView.backgroundColor = .clear
                    
                    containerView.layoutIfNeeded()
                })
                
            }
            
        })
 
    }
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1.3
    }
}
