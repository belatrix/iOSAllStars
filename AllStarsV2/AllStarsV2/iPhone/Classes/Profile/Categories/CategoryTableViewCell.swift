//
//  CategoryTableViewCell.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 2/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStars: UILabel!
    
    var fontTitleInitial : UIFont!
    var titleColorInitial : UIColor!
    var objCategory : CategoryBE!{
        
        didSet{
            self.update()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        self.fontTitleInitial = self.lblName.font
        self.titleColorInitial = self.lblName.textColor
    }
    
    func update(){
        
        self.lblName.text = self.objCategory.category_name
        self.lblStars.text = "\(self.objCategory.category_num_stars)"
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
