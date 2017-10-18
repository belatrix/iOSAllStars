//
//  EventCategoryDetailTableViewCell.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/28/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EventCategoryDetailTableViewCell: UITableViewCell {
    
    var objEventBE : EventBE!{
        didSet{
            self.updateData()
        }
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var viewImgContainer: UIView!
    
    override func prepareForReuse() {
        self.imgEvent.image = nil
    }
    
    override func draw(_ rect: CGRect) {
        self.viewImgContainer.layer.cornerRadius = 8
        self.viewImgContainer.layer.shadowRadius = 3
        self.viewImgContainer.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.viewImgContainer.layer.shadowOpacity = 0.6
        self.viewImgContainer.layer.masksToBounds = false
        
        self.imgEvent.layer.cornerRadius = 8
        self.imgEvent.layer.masksToBounds = true
        
        self.clipsToBounds = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(){
        self.lblTitle.text = "\(self.objEventBE.event_name)"
        self.lblDate.text = CDMDateManager.convertirFecha(self.objEventBE.event_datetime, enTextoConFormato: "EEEE dd '\("de".localized)' MMMM',' yyyy")
        self.lblTime.text = CDMDateManager.convertirFecha(self.objEventBE.event_datetime, enTextoConFormato: "HH:mm")
        self.lblLocation.text = ("\(self.objEventBE.event_location!.location_name)" + " " + "\(self.objEventBE.event_address)")
        
        CDMImageDownloaded.descargarImagen(enURL: objEventBE.event_image, paraImageView: self.imgEvent, conPlaceHolder: self.imgEvent.image) { (isCorrect, urlImage, image) in
            self.imgEvent.image = image
        }
    }

}
