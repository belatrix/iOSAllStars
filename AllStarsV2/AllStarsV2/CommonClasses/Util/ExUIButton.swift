//
//  ExUIButton.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 31/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

extension UIButton {

    func selectTextField(){
        
        UIView.animate(withDuration: 0.25) {
            
            self.layer.borderColor = Constants.MAIN_COLOR.cgColor
            self.layer.borderWidth = 1
        }
    }
    
    
    func deselectTextField(){
        
        UIView.animate(withDuration: 0.25) {
            
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.borderWidth = 1
        }
    }
    
    func makeBorder(){
        
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
    
}
