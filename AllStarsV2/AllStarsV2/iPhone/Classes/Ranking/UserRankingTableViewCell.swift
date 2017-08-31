//
//  UserRankingTableViewCell.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 18/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class UserRankingTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName      : UILabel!
    @IBOutlet weak var lblRating    : UILabel!
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
        self.lblRating.text = "\(self.objContact.user_value)"
        self.imgUser.objUser = self.objContact
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
