//
//  ExUIImageView.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 26/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func makeRound() -> Void {
        
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 6
        self.layer.masksToBounds = true
        
    }
}
