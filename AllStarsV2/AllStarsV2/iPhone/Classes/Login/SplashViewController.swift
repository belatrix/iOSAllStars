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
    
    func iniciarLogin(){
        
        self.performSegue(withIdentifier: "LoginViewController", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialColor = self.view.backgroundColor
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.performSegue(withIdentifier: "LoginViewController", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



