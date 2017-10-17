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
        
        let aboutStoryboard = UIStoryboard(name: "About", bundle: nil)
        array.append(aboutStoryboard.instantiateInitialViewController()!)
        
        let tutorialStoryboard = UIStoryboard(name: "Tutorial", bundle: nil)
        array.append(tutorialStoryboard.instantiateInitialViewController()!)
        
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
    
    @IBAction private func logOutButtonTapped(_ sender: UIButton) {
        CDMUserAlerts.showMultipleAlert(title: "app_name".localized, withMessage: "logout".localized, withButtons: ["yes".localized], withCancelButton: "cancel".localized, withController: self) { (index) in
            
            UserBC.deleteSession()
            _ = self.navigationController?.popToRootViewController(animated: true)
                                            
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
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }


}
