//
//  CDMLoadingView.swift
//  MapSalud
//
//  Created by KenyiMetal on 3/10/16.
//  Copyright © 2016 KenyiMetal. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol CDMLoadingViewDelegate : NSObjectProtocol{
    
    @objc optional func loadingView(_ loadingView : CDMLoadingView, reintentar btnReintentar : UIButton?)
}


public class CDMLoadingView: UIView  {

    @IBOutlet public weak var lblMensaje           : UILabel?
    @IBOutlet public weak var actividadCargando    : UIActivityIndicatorView?
    @IBOutlet public weak var btnReintentar        : UIButton?
    
    weak open var delegate : CDMLoadingViewDelegate?
    
    public func iniciarLoading(conMensaje mensaje : String?, conAnimacion animacion : Bool) {
        
        self.btnReintentar?.alpha = 0
        
        self.lblMensaje?.text = mensaje != nil ? mensaje : ""
        
        if animacion {
            self.actividadCargando?.startAnimating()
        }else{
            self.actividadCargando?.stopAnimating()
        }
        
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
        }
    }
    
    
    public func detenerLoading(){
        
        self.actividadCargando?.stopAnimating()
        self.lblMensaje?.text = ""
        self.btnReintentar?.alpha = 0
        
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 0
        }
    }
    
    
    public func mostrarError(conMensaje mensaje : String?, conOpcionReintentar reintentar : Bool){
        
        self.lblMensaje?.text = mensaje != nil ? mensaje : ""
        self.btnReintentar?.alpha = reintentar ? 1 : 0
        self.actividadCargando?.stopAnimating()
        
        UIView.animate(withDuration: 0.3) { 
            
            self.alpha = 1
        }
    }
    
    
    @IBAction public func clicBtnReintentar(_ sender: AnyObject?) {
        
        self.delegate?.loadingView!(self, reintentar: self.btnReintentar)
    }
    
}
