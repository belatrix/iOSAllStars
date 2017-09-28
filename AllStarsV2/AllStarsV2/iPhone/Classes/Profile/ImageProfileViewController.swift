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
    
    @IBOutlet weak var imgUser      : UIImageView!
    @IBOutlet weak var scrollZoom   : UIScrollView!
    @IBOutlet weak var userProfileImageBackgroundView           : UIView!
    /* @IBOutlet weak var userProfileImageViewLeadingConstraint    : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewTopConstraint        : NSLayoutConstraint! */
    @IBOutlet weak var userProfileImageViewCenterXConstraint    : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewCenterYConstraint    : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewWidthConstraint      : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewHeightConstraint     : NSLayoutConstraint!
    
    var newProfileImageViewHeight: CGFloat = 0.0
    var objUser : UserBE!
    
    
    
    
    
    // MARK: - @IBAction/action methods
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /* @IBAction func doubleTapToRestartScale(_ sender: Any) {
        UIView.animate(withDuration: 0.35,
                       animations: {
                        
            self.imgUser.transform = CGAffineTransform.identity
            self.scrollZoom.contentSize = CGSize(width: self.imgUser.frame.width, height: self.imgUser.frame.height)
                        
        }) { (_) in
            
            UIView.animate(withDuration: 0.35) {
                
            }
            
        }
    } */
    
    
    
    
    
    // MARK: - UIScrollViewDelegate methods
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgUser
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.scrollZoom.contentSize = CGSize(width: self.imgUser.frame.width, height: self.imgUser.frame.height)
    }
    
    
    
    
    
    // MARK: - ImageProfileViewController's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()

        // Configuraciones adicionales.
        // self.newProfileImageViewHeight = self.userProfileImageViewHeightConstraint.constant
        
        /* CDMImageDownloaded.descargarImagen(enURL: self.objUser.user_avatar, paraImageView: self.imgUser, conPlaceHolder: self.imgUser.image) { (isCorrect, urlImage, image) in */
            /* if image != nil {
                self.imgUser.contentMode = (image!.size.width > image!.size.height) ? UIViewContentMode.scaleAspectFit : UIViewContentMode.scaleAspectFill
            }
            
            self.imgUser.contentMode = .scaleAspectFit
            self.imgUser.image = image
            
            print(image!.size)
            print(self.imgUser.frame) */
            
            /* guard let profileImage = image else { return }
            self.imgUser.image = profileImage
            
            if profileImage.size.width > self.imgUser.frame.width {
                
                /*
                 El ancho de la imagen es mayor al del 'UIImageView'.
                 ¿Qué se hace? (1) Se asigna el valor '.scaleAspectFit' a la propiedad 'contentMode' y (2) se calcula la nueva altura del control 'UIImageView' en función al valor del "aspect ratio" de la imagen.
                 */
                
                self.imgUser.contentMode = .scaleToFill
                
                let aspectRatioForImage = (profileImage.size.width / profileImage.size.height)
                if profileImage.size.width > profileImage.size.height { /* Hay más ancho que alto. */
                    self.newProfileImageViewHeight = (self.userProfileImageViewWidthConstraint.constant / aspectRatioForImage)
                    self.userProfileImageViewHeightConstraint.constant = self.newProfileImageViewHeight
                    print("new size for UIImageView: \(self.userProfileImageViewWidthConstraint.constant) x \(self.newProfileImageViewHeight)")
                }
                else { /* La imagen tiene más alto que ancho o es un cuadrado. */
                    
                }
            } */
        // }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
