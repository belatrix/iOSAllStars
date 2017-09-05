//
//  EventNewsTableViewCell.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 9/1/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EventNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgEventActivity: UIImageView!
    
    var objEventActivity : ActivityEventBE!{
        didSet{
            self.updateData()
        }
    }

    
    func updateData(){
        let date   = CDMDateManager.convertirFecha(self.objEventActivity.activity_datetime, enTextoConFormato: "yyyy/dd/MM")
        let time   = CDMDateManager.convertirFecha(self.objEventActivity.activity_datetime, enTextoConFormato: "HH:mm")
        
        self.lblDateTime.text = "\(date) - \(time)"
        self.lblDescription.text = self.objEventActivity.activity_description
        
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
