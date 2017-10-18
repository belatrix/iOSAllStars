//
//  ImageProfileViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 31/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ImageProfileViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var pbImageView  : PBImageView!
    @IBOutlet weak var closeButton  : UIButton!
    @IBOutlet weak var scrollZoom   : UIScrollView!
    @IBOutlet weak var statusBarView                            : UIView!
    @IBOutlet weak var userProfileImageViewCenterXConstraint    : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewCenterYConstraint    : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewWidthConstraint      : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewHeightConstraint     : NSLayoutConstraint!
    @IBOutlet weak var doubleTapGestureRecognizer               : UITapGestureRecognizer!
    
    var objUser: UserBE!
    var initialImageViewFrame: CGRect       = CGRect.zero
    var initialImageViewCenter: CGPoint     = CGPoint.zero
    var newProfileImageViewHeight: CGFloat  = 0.0
    
    
    
    
    
    // MARK: - @IBAction/action methods
    
    @objc func doubleTap(_ gesture: UIGestureRecognizer) {
        if self.scrollZoom.zoomScale <= 1.0 { /* Hacer zoom... */
            let maxZoomScale = (self.scrollZoom.maximumZoomScale / 2.0)
            self.scrollZoom.setZoomScale(maxZoomScale,
                                         animated: true)
        }
        else { /* Quitar zoom... */
            self.scrollZoom.setZoomScale(1.0,
                                         animated: true)
        }
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        let customAnimationsClosure: (() -> ()) = {  [unowned self] in
            self.pbImageView.contentMode = .scaleAspectFill
            
            self.userProfileImageViewCenterXConstraint.constant = (((self.scrollZoom.bounds.width / 2.0) * -1.0) + (self.initialImageViewCenter.x - 8.0))
            self.userProfileImageViewCenterYConstraint.constant = (((self.scrollZoom.bounds.height / 2.0) * -1.0) + (self.initialImageViewCenter.y - 35.0))
            self.userProfileImageViewWidthConstraint.constant   = self.initialImageViewFrame.width
            self.userProfileImageViewHeightConstraint.constant  = self.initialImageViewFrame.height
        }
        let defaultsAnimationsClosure: (() -> ()) = { [unowned self] in
            self.closeButton.alpha = 0.0
            
            self.scrollZoom.backgroundColor     = UIColor.white.withAlphaComponent(0.0)
            self.statusBarView.backgroundColor  = UIColor.white.withAlphaComponent(0.0)
            
            self.pbImageView.layer.cornerRadius = (self.initialImageViewFrame.width / 2.0)
        }
        
        let animationDuration = 0.5
        
        let colorAnimation          = CABasicAnimation(keyPath: "borderColor");
        colorAnimation.fromValue    = UIColor.white.withAlphaComponent(0.0).cgColor
        colorAnimation.toValue      = UIColor.white.cgColor
        colorAnimation.beginTime    = (CACurrentMediaTime() + (0.75 * animationDuration))
        colorAnimation.duration     = (0.25 * animationDuration)
        colorAnimation.repeatCount  = 1
        colorAnimation.fillMode     = kCAFillModeForwards
        colorAnimation.isRemovedOnCompletion = false
        self.pbImageView.layer.add(colorAnimation,
                                   forKey: "BorderColorAnimationKey");
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            defaultsAnimationsClosure()
            customAnimationsClosure()
                        
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            UIApplication.shared.statusBarStyle = .lightContent
            self.doubleTapGestureRecognizer.isEnabled = false
            
            self.dismiss(animated: false,
                         completion: nil)
        })
    }
    
    
    
    
    
    // MARK: - UIScrollViewDelegate methods
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.pbImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1.0 {
            self.closeButton.alpha = 0.0
            
            if let image = self.pbImageView.image {
                let ratioW  = (self.pbImageView.frame.width / image.size.width)
                let ratioH  = (self.pbImageView.frame.height / image.size.height)
                let ratio   = (ratioW < ratioH) ? ratioW : ratioH
                
                let newWidth    = (image.size.width * ratio)
                let newHeight   = (image.size.height * ratio)
                let left    = 0.5 * (newWidth * scrollView.zoomScale > self.pbImageView.frame.width     ? (newWidth - self.pbImageView.frame.width)     : (scrollView.frame.width - scrollView.contentSize.width))
                let top     = 0.5 * (newHeight * scrollView.zoomScale > self.pbImageView.frame.height   ? (newHeight - self.pbImageView.frame.height)   : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsetsMake(top, left, top, left)
            }
        }
        else {
            self.closeButton.alpha = 1.0
            scrollView.contentInset = UIEdgeInsets.zero
        } 
    }
    
    
    
    
    
    // MARK: - ImageProfileViewController's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()

        // Configuraciones adicionales.
        self.doubleTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(self.doubleTap(_:)))
        self.doubleTapGestureRecognizer.numberOfTapsRequired = 2
        self.doubleTapGestureRecognizer.isEnabled = false
        self.scrollZoom.addGestureRecognizer(self.doubleTapGestureRecognizer)
        
        self.closeButton.alpha = 0.0

        let centerX: CGFloat = (self.initialImageViewCenter.x <= 0.0) ? 86.0     : self.initialImageViewCenter.x
        let centerY: CGFloat = (self.initialImageViewCenter.y <= 0.0) ? 164.0    : self.initialImageViewCenter.y
        self.userProfileImageViewCenterXConstraint.constant = (((UIScreen.main.bounds.width / 2.0) * -1.0) + (centerX - 8.0))
        self.userProfileImageViewCenterYConstraint.constant = ((((UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height) / 2.0) * -1.0) + (centerY - 35.0))
        self.userProfileImageViewWidthConstraint.constant   = (self.initialImageViewFrame.width <= 0.0)     ? 140.0 : self.initialImageViewFrame.width
        self.userProfileImageViewHeightConstraint.constant  = (self.initialImageViewFrame.height <= 0.0)    ? 140.0 : self.initialImageViewFrame.height
        
        self.pbImageView.layer.cornerRadius = (self.userProfileImageViewWidthConstraint.constant / 2.0)
        self.pbImageView.layer.borderColor  = UIColor.white.withAlphaComponent(0.0).cgColor
        self.pbImageView.layer.borderWidth  = 5.0
        self.pbImageView.contentMode = .scaleAspectFill
        
        self.view.layoutIfNeeded()
        CDMImageDownloaded.descargarImagen(enURL: self.objUser.user_avatar,
                                           paraImageView: nil,
                                           conPlaceHolder: nil) { [weak self] (isCorrect, urlImage, image) in
                                            
            self?.pbImageView.image = image
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layoutIfNeeded()
        
        // Configuraciones adicionales.
        guard let _ = self.pbImageView.image else { return }
        
        UIApplication.shared.statusBarStyle = .default
        
        let customAnimationsClosure: (() -> ()) = {  [unowned self] in
            self.pbImageView.contentMode = .scaleAspectFit
            
            self.userProfileImageViewHeightConstraint.constant  = (UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height)
            self.userProfileImageViewWidthConstraint.constant   = UIScreen.main.bounds.width
            
            self.userProfileImageViewCenterXConstraint.constant = 0.0
            self.userProfileImageViewCenterYConstraint.constant = 0.0
        }
        let defaultsAnimationsClosure: (() -> ()) = { [unowned self] in
            self.closeButton.alpha = 1.0
            
            self.pbImageView.layer.cornerRadius = 0.0
            
            self.scrollZoom.backgroundColor     = UIColor.white.withAlphaComponent(0.75)
            self.statusBarView.backgroundColor  = UIColor.white.withAlphaComponent(0.75)
        }
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.75,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            defaultsAnimationsClosure()
            customAnimationsClosure()
            
            self.view.layoutIfNeeded()
        }, completion: { (_) in
            self.doubleTapGestureRecognizer.isEnabled = true
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
