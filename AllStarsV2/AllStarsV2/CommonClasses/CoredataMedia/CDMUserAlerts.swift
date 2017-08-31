//
//  CDMUserAlerts.swift
//  RapiDocMedicos
//
//  Created by Kenyi Rodriguez on 17/04/16.
//  Copyright © 2016 Core Data Media. All rights reserved.
//

import UIKit

public class CDMUserAlerts: NSObject {
    
    public class func showActionSheet(withTitle title: String, withMessage message : String, withButtons buttons: [String], withCancelButton cancelButton: String, inController controller: UIViewController, withSelectionButtonIndex completion: @escaping(_ btnIndex : Int) -> Void, withActionCancel cancel: (() -> ())?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for buttonTitle in buttons {
            
            let actionBtn = UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
                completion(buttons.index(of: buttonTitle)!)
            })
            
            alertController.addAction(actionBtn)
        }
        
        let accionBtn = UIAlertAction(title: cancelButton, style: .cancel, handler: { (action) in
            if cancel != nil {
                cancel!()
            }
        })
        
        alertController.addAction(accionBtn)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    public class func showSimpleAlert(title: String, withMessage message : String, withAcceptButton accept: String, withController controller : UIViewController, withCompletion completion : (() -> Void)?){
        
        let alertaController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let accionCancelar = UIAlertAction(title: accept, style: UIAlertActionStyle.cancel) { (action : UIAlertAction) in
            
            completion?()
        }
        
        alertaController.addAction(accionCancelar)
        controller.present(alertaController, animated: true, completion: nil)
    }

}
