//
//  ContactCollectionViewCell.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 11/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblName  : UILabel!
    @IBOutlet weak var imgUser  : ImageUserProfile!
    
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
        
        self.lblName.text = "\(self.objContact.user_first_name!) \(self.objContact.user_last_name!)"
        self.imgUser.objUser = self.objContact
    }
    

}
