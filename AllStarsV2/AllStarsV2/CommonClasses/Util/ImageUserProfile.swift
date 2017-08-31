//
//  ImageUserProfile.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 18/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ImageUserProfile: UIView {

    var image : UIImage?{
        didSet{
            
            self.imgUser.image = image
            
            if self.image == nil {
                self.lblAbrev.alpha = 1
                self.imgUser.alpha = 0
            }else{
                self.lblAbrev.alpha = 0
                self.imgUser.alpha = 1
            }
            
            
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
            
            let firstName = self.objUser.user_first_name!.characters.first != nil ? "\(self.objUser.user_first_name!.characters.first!)" : ""
            let lastName = self.objUser.user_last_name!.characters.first != nil ? "\(self.objUser.user_last_name!.characters.first!)" : ""
            
            let abrev = "\(firstName)\(lastName)".uppercased()
            self.lblAbrev.text = abrev
            
            CDMImageDownloaded.descargarImagen(enURL: self.objUser.user_avatar, paraImageView: self.imgUser, conPlaceHolder: self.imgUser.image) { (isCorrect, urlImage, image) in
                
                if urlImage == self.objUser.user_avatar{
                    self.imgUser.image = image
                }
            }

            self.lblAbrev.alpha = self.objUser.user_avatar.characters.count == 0 ? 1 : 0
            self.imgUser.alpha = self.objUser.user_avatar.characters.count == 0 ? 0 : 1
            
        }
    }
    
    lazy var lblAbrev : UILabel = {
       
        let _lblAbrev = UILabel()
        _lblAbrev.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        _lblAbrev.textColor = .white
        _lblAbrev.textAlignment = .center
//        _lblAbrev.translatesAutoresizingMaskIntoConstraints = false
        
        
        return _lblAbrev
    }()
    
    
    lazy var imgUser : UIImageView = {
       
        let _imgUser = UIImageView()
        _imgUser.contentMode = .scaleAspectFill
        _imgUser.clipsToBounds = true
        
//        _imgUser.translatesAutoresizingMaskIntoConstraints = false
        return _imgUser
        
    }()
    
    
    func animateBordeWidthFromValue(_ fromValue: CGFloat, toValue: CGFloat){
        
        let widthAnimation = CABasicAnimation(keyPath: "borderWidth")
        widthAnimation.fromValue = fromValue
        widthAnimation.toValue = toValue
        widthAnimation.duration = 1
//        self.layer.borderWidth = toValue
        
        let bothAnimations = CAAnimationGroup()
        bothAnimations.duration = 1
        bothAnimations.animations = [widthAnimation]
        bothAnimations.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        self.layer.add(bothAnimations, forKey: "color and width")
    }
    
    
    func showUserNameAbrev(_ show : Bool){
        
        self.imgUser.alpha = show ? 0 : 1
        self.lblAbrev.alpha = show ? 1 : 0
    }
    
    func setInitialVisualConfiguration(){
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderColor = self.borderImageColor
        self.layer.borderWidth = self.borderImage
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
    
        self.addSubview(self.imgUser)
        self.addSubview(self.lblAbrev)
        
        self.imgUser.frame.size = rect.size
        self.imgUser.frame.origin = CGPoint(x: 0, y: 0 )
        
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[imgUser]-0-|", options: [], metrics: nil, views: ["imgUser" : self.imgUser]))
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[imgUser]-0-|", options: [], metrics: nil, views: ["imgUser" : self.imgUser]))

//        let lblwidth = self.lblAbrev.widthAnchor.constraint(equalToConstant: 250)
//        let lblheight = self.lblAbrev.heightAnchor.constraint(equalToConstant: 250)
//        let centerx = self.lblAbrev.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
//        let centery = self.lblAbrev.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
//        NSLayoutConstraint.activate([lblwidth, lblheight, centerx, centery])
        
        let delta = self.bounds.size.height / 250
        self.lblAbrev.transform = CGAffineTransform(scaleX: delta, y: delta)
        
    }
    

}
