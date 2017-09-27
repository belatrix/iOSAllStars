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
    @IBOutlet weak var userProfileImageViewLeadingConstraint    : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewTopConstraint        : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewWidthConstraint      : NSLayoutConstraint!
    @IBOutlet weak var userProfileImageViewHeightConstraint     : NSLayoutConstraint!
    
    var objUser : UserBE!
    
    
    
    
    
    // MARK: - @IBAction/action methods
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doubleTapToRestartScale(_ sender: Any) {
        UIView.animate(withDuration: 0.35,
                       animations: {
                        
            self.imgUser.transform = CGAffineTransform.identity
            self.scrollZoom.contentSize = CGSize(width: self.imgUser.frame.width, height: self.imgUser.frame.height)
                        
        }) { (_) in
            
            UIView.animate(withDuration: 0.35) {
                
            }
            
        }
    }
    
    
    
    
    
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

        // Configuraciones adicionales.
        CDMImageDownloaded.descargarImagen(enURL: self.objUser.user_avatar, paraImageView: self.imgUser, conPlaceHolder: self.imgUser.image) { (isCorrect, urlImage, image) in
            if image != nil {
                self.imgUser.contentMode = image!.size.width > image!.size.height ? UIViewContentMode.scaleAspectFit : UIViewContentMode.scaleAspectFill
            }
            
            self.imgUser.image = image
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
