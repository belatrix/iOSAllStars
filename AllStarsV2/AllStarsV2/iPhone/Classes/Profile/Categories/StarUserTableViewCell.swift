//
//  StarUserTableViewCell.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 8/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

protocol StarUserTableViewCellDelegate {
    func starUserTableViewCell(_ cell: StarUserTableViewCell, selectStar objStar : StarUserBE) -> Void
}

class StarUserTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUser          : ImageUserProfile!
    @IBOutlet weak var lblNameUser      : UILabel!
    @IBOutlet weak var lblPositionName  : UILabel!
    @IBOutlet weak var lblDate          : UILabel!
    @IBOutlet weak var lblText          : UILabel?
    @IBOutlet weak var btnKeyword       : UIButton!
    @IBOutlet weak var btnSeeMore       : UIButton?
    
    var delegate : StarUserTableViewCellDelegate!
    
    var objStar : StarUserBE! {
        
        didSet{
            self.updateData()
        }
    }
    
    @IBAction func clicBtnSeeMore(_ sender: Any) {
        
        self.lblText?.numberOfLines = self.objStar.star_explainDetail ? 0 : 1
        self.btnSeeMore?.setTitle(!self.objStar.star_explainDetail ? "see_more".localized : "see_less".localized , for: .normal)
        self.objStar.star_explainDetail = !self.objStar.star_explainDetail
        self.delegate.starUserTableViewCell(self, selectStar: self.objStar)
    }
    
    override func draw(_ rect: CGRect) {
        
        self.imgUser.setInitialVisualConfiguration()
        self.imgUser.borderImage = 0
        
    }
    
    func updateData(){
        
        self.lblNameUser.text = "\(self.objStar.star_fromUser.user_first_name!) \(self.objStar.star_fromUser.user_last_name!)"
        self.lblDate.text = CDMDateManager.convertirFecha(self.objStar.star_date, enTextoConFormato: "dd/MM/yyyy")
        self.lblPositionName.text = self.objStar.star_fromUser.user_username
        self.btnSeeMore?.setTitle(!self.objStar.star_explainDetail ? "see_more".localized : "see_less".localized , for: .normal)
        self.lblText?.numberOfLines = self.objStar.star_explainDetail ? 0 : 1
        self.lblText?.text = self.objStar.star_comment
        self.btnKeyword.setTitle(self.objStar.star_keyword.keyword_name, for: .normal)
        
        self.imgUser.objUser = self.objStar.star_fromUser
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
