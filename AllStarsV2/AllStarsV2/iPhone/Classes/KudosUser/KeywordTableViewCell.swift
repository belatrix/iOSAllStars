//
//  KeywordTableViewCell.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 26/09/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class KeywordTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNameKeyword: UILabel!
    
    var objKeyword : KeywordBE!{
        
        didSet{
            self.lblNameKeyword.text = self.objKeyword.keyword_name.uppercased()
        }
    }
    
    
    func selectCell(_ state : Bool){
        
        UIView.animate(withDuration: 0.35) {
            
            self.lblNameKeyword.textColor = state ? Constants.SECOND_COLOR : UIColor.darkGray
            let scale : CGFloat = state ? 1.05 : 1
            self.lblNameKeyword.transform = CGAffineTransform(scaleX: scale, y: scale)
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
