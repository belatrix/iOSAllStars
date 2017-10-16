//
//  AddKeywordTableViewCell.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 28/09/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AddKeywordTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle : UILabel!
    
    var objTitleTag = "" {
        didSet{
            self.lblTitle.text = String.init(format: "create_tag".localized, self.objTitleTag)
        }
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
