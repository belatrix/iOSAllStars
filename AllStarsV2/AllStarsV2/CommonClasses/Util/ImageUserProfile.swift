//
//  ImageUserProfile.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 18/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit


class ImageUserProfile: UIView {
    
    var image               : UIImage?{    
        didSet{
    
            self.imgUser.image = image    
        }
    }
    
    var borderImageColor : CGColor = UIColor.white.cgColor {
        
        didSet{
            self.layer.borderColor = self.borderImageColor
        }
    }
    
    func setBorderAnimated(newBorder : CGFloat){
        self.animateBordeWidthFromValue(self.borderImage, toValue: newBorder)
    }
    
    var borderImage : CGFloat = 0 {

        didSet{
            self.layer.borderWidth = self.borderImage
        }
    }
    
    var objUser : UserBE!{
        
        didSet{
            
            self.backgroundColor = self.objUser.user_color
            
            CDMImageDownloaded.descargarImagen(enURL: self.objUser.user_avatar, paraImageView: self.imgUser, conPlaceHolder: #imageLiteral(resourceName: "userPlaceHolder")) { (isCorrect, urlImage, image) in
                
                if urlImage == self.objUser.user_avatar{
                    self.image = image
                }
            }            
        }
    }
    
    lazy var imgUser : UIImageView = {
       
        let _imgUser = UIImageView()
        _imgUser.contentMode = .scaleAspectFill
        _imgUser.clipsToBounds = true
        
        _imgUser.translatesAutoresizingMaskIntoConstraints = false
        return _imgUser
        
    }()
    
    
    func animateBordeWidthFromValue(_ fromValue: CGFloat, toValue: CGFloat){
        
        let widthAnimation = CABasicAnimation(keyPath: "borderWidth")
        widthAnimation.fromValue = fromValue
        widthAnimation.toValue = toValue
        widthAnimation.duration = 1
        
        let bothAnimations = CAAnimationGroup()
        bothAnimations.duration = 1
        bothAnimations.animations = [widthAnimation]
        bothAnimations.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        self.layer.add(bothAnimations, forKey: "color and width")
    }
    
    
    func setInitialVisualConfiguration(){
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderColor = self.borderImageColor
        self.layer.borderWidth = self.borderImage
    }
    

    override func draw(_ rect: CGRect) {
    
        self.addSubview(self.imgUser)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[imgUser]-0-|", options: [], metrics: nil, views: ["imgUser" : self.imgUser]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[imgUser]-0-|", options: [], metrics: nil, views: ["imgUser" : self.imgUser]))
        
    }
    

}
