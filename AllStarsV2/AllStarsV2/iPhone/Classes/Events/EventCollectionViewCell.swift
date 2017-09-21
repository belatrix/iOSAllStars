//
//  EventCollectionViewCell.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/24/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewImgContainer : UIView!
    @IBOutlet weak var imgEvent         : UIImageView!
    @IBOutlet weak var lblEventName     : UILabel!
    
    
    var objEvent : EventBE!{
        didSet{
            self.updateData()
        }
    }
    
    override func draw(_ rect: CGRect) {
    
        
        self.viewImgContainer.layer.cornerRadius = 8
        self.viewImgContainer.layer.shadowRadius = 2
        self.viewImgContainer.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.viewImgContainer.layer.shadowOpacity = 0.45
        self.viewImgContainer.layer.masksToBounds = false
        
        self.imgEvent.layer.cornerRadius = 8
        self.imgEvent.layer.masksToBounds = true
   
        self.clipsToBounds = false
    }
    

    func updateData(){
  
        self.lblEventName.text = "\(self.objEvent.event_name)"
        CDMImageDownloaded.descargarImagen(enURL: objEvent.event_image, paraImageView: self.imgEvent, conPlaceHolder: self.imgEvent.image) { (isCorrect, urlImage, image) in
            if urlImage == self.objEvent.event_image{
                self.imgEvent.image = image
            }
        }
    }
    
    
    
}
