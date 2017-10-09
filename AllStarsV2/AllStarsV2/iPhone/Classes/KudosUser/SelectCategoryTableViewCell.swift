//
//  SelectCategoryTableViewCell.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 2/10/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class SelectCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCategoryName: UILabel!
    
    var objCategory : CategoryBE!{
        
        didSet{
            self.updateData()
        }
    }
    
    func selectCell(_ state : Bool){
        
        UIView.animate(withDuration: 0.35) {
            
            self.lblCategoryName.textColor = state ? Constants.SECOND_COLOR : UIColor.darkGray
            let scale : CGFloat = state ? 1.05 : 1
            self.lblCategoryName.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func updateData(){
        
        self.lblCategoryName.text = self.objCategory.category_name
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
