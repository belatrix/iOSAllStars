//
//  SplashViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 19/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imgLogo          : UIImageView!
    @IBOutlet weak var loadingActivity  : UIActivityIndicatorView!
    
    var initialColor : UIColor!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initialColor = self.view.backgroundColor
    }

    func loadDataInformation(){
        
        if let objSession = UserBC.getUserSession(){
            
            self.loadingActivity.startAnimating()
            
            UserBC.getUserInformationById(objSession.session_user_id.intValue, withSuccessful: { (objUser) in
                
                self.loadingActivity.stopAnimating()
                UserBE.shareInstance = objUser
                self.performSegue(withIdentifier: "RevealViewController", sender: nil)
                
            }) { (title, message) in
                
                self.loadingActivity.stopAnimating()
                CDMUserAlerts.showSimpleAlert(title: title, withMessage: message, withAcceptButton: "ok".localized, withController: self, withCompletion: {
                    self.loadDataInformation()
                })
            }
            
        }else{
            self.performSegue(withIdentifier: "LoginViewController", sender: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.loadDataInformation()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
}



