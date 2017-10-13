//
//  SplashViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 19/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    
    var initialColor : UIColor!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initialColor = self.view.backgroundColor
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let objSession = UserBC.getUserSession(){
            
            UserBC.getUserInformationById(objSession.session_user_id.intValue, withSuccessful: { (objUser) in
                
                UserBE.shareInstance = objUser
                self.performSegue(withIdentifier: "RevealViewController", sender: nil)
                
            }) { (title, message) in
                
                CDMUserAlerts.showSimpleAlert(title: title, withMessage: message, withAcceptButton: "ok".localized, withController: self, withCompletion: nil)
            }
            
        }else{
            self.performSegue(withIdentifier: "LoginViewController", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
}



