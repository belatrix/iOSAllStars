//
//  AboutCollaboratorCollectionViewCell.swift
//  AllStarsV2
//
//  Created by Javier Siancas Fajardo on 10/11/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AboutCollaboratorCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet internal weak var pictureImageView: UIImageView!
    @IBOutlet internal weak var nameLabel: UILabel!
    
    
    
    
    
    // MARK: - AboutCollaboratorCollectionViewCell's methods
    
    override func awakeFromNib() {
        self.pictureImageView.layer.cornerRadius = (self.pictureImageView.frame.height / 2.0)
    }
    
}
