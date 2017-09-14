//
//  ImageProfileViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 31/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ImageProfileViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imgUser      : UIImageView!
    @IBOutlet weak var scrollZoom   : UIScrollView!
    
    var objUser : UserBE!
    
    @IBAction func doubleTapToRestartScale(_ sender: Any) {
        
        
        
        UIView.animate(withDuration: 0.35, animations: {
            self.imgUser.transform = CGAffineTransform.identity
            self.scrollZoom.contentSize = CGSize(width: self.imgUser.frame.width, height: self.imgUser.frame.height)
        }) { (_) in
            UIView.animate(withDuration: 0.35) {
                
            }
            
        }
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return self.imgUser
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        self.scrollZoom.contentSize = CGSize(width: self.imgUser.frame.width, height: self.imgUser.frame.height)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
