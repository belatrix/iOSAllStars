//
//  UserRankingTableViewCell.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 18/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class UserRankingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblName      : UILabel!
    @IBOutlet weak var imgUser      : ImageUserProfile!
    @IBOutlet weak var progressRanking: UIProgressView!
    
    var maxValue                    : Int = 0
    var objContact : UserBE!{
        didSet{
            self.updateData()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        self.imgUser.setInitialVisualConfiguration()
        self.imgUser.borderImage = 0
    }
    
    func updateData(){
        
//        UIView.animateKeyframes(withDuration: 1, delay: 1, options: [], animations: {
//            self.progressRanking.progress = Float(self.objContact.user_value) / Float(self.maxValue)
//        }, completion: nil)
        self.progressRanking.setProgress(Float(self.objContact.user_value) / Float(self.maxValue), animated: true)
        
        self.lblName.text = "\(self.objContact.user_first_name!) \(self.objContact.user_last_name!)"
        self.imgUser.objUser = self.objContact
    }

}
