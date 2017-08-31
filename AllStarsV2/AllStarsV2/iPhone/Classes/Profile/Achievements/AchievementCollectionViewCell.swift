//
//  AchievementCollectionViewCell.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 9/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AchievementCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var objAchievement : AchievementBE!{
        
        didSet{
            self.updateData()
        }
    }
    
    func updateData(){
        
        self.lblName.text = self.objAchievement.achievement_badge.badge_name
        
        CDMImageDownloaded.descargarImagen(enURL: self.objAchievement.achievement_badge.badge_icon, paraImageView: self.imgIcon, conPlaceHolder: self.imgIcon.image) { (isCorrect, urlImage, image) in
            
            if urlImage == self.objAchievement.achievement_badge.badge_icon {
                self.imgIcon.image = image
            }
        }
    }
}
