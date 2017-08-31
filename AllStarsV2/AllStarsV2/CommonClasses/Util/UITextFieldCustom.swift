//
//  UITextFieldCustom.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 26/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class UITextFieldCustom: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    
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
