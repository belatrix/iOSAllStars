//
//  MenuViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 22/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var arrayButtonsMenu: [UIButton]!
    
    
    lazy var arrayViewControllers : [UIViewController] = {
       
        var array = [UIViewController]()
        
        let storyBoardProfile = UIStoryboard(name: "Profile", bundle: nil)
        array.append(storyBoardProfile.instantiateViewController(withIdentifier: "UserProfileNavViewController"))
        
        let storyBoardeEvents = UIStoryboard(name: "Events", bundle: nil)
        array.append(storyBoardeEvents.instantiateViewController(withIdentifier: "EventsNavViewController"))
        
        let storyBoardeContacts = UIStoryboard(name: "Contacts", bundle: nil)
        array.append(storyBoardeContacts.instantiateViewController(withIdentifier: "ContactsNavViewController"))
        
        let storyBoardeRanking = UIStoryboard(name: "Ranking", bundle: nil)
        array.append(storyBoardeRanking.instantiateViewController(withIdentifier: "RankingNavViewController"))
        
        return array
    }()
    
    
    @IBAction func clickBtnMenu(_ sender: UIButton) {
        
        self.revealViewController().frontViewController = self.arrayViewControllers[sender.tag]
        
        UIView.animate(withDuration: 0.3, animations: {
            
            for btn in self.arrayButtonsMenu{
                
                btn.tintColor = btn == sender ? Constants.MAIN_COLOR : UIColor.lightGray
                btn.backgroundColor = btn == sender ? CDMColorManager.colorFromHexString("F5F5F5", withAlpha: 1) : UIColor.clear
                btn.titleLabel?.font = btn == sender ? UIFont(name: "HelveticaNeue", size: 16) : UIFont(name: "HelveticaNeue-Light", size: 16)
            }
            
        }) { (_) in
            
            self.revealViewController().revealToggle(animated: true)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
      
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
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
