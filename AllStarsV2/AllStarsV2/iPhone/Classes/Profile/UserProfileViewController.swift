//
//  UserProfileViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 2/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class UserProfileViewController: SWFrontGenericoViewController, UIScrollViewDelegate {

    @IBOutlet weak var imgUser                  : ImageUserProfile?
    @IBOutlet weak var lblNameUser              : UILabel?
    @IBOutlet weak var lblScore                 : UILabel?
    @IBOutlet weak var lblLevel                 : UILabel?
    @IBOutlet weak var btnMail                  : UIButton?
    @IBOutlet weak var btnSkype                 : UIButton?
    @IBOutlet weak var btnLocation              : UIButton?
    @IBOutlet weak var constraintSectionSelected: NSLayoutConstraint!
    @IBOutlet var arrayButtonsSection           : [UIButton]!
    @IBOutlet var arrayVistas                   : [UIView]!
    @IBOutlet weak var scrollContent            : UIScrollView!
    @IBOutlet weak var constraintTopHeader      : NSLayoutConstraint!
    @IBOutlet weak var viewContainerInfo        : UIView!
    @IBOutlet weak var constraintTopSections    : NSLayoutConstraint!
    @IBOutlet weak var constraintBottomSections : NSLayoutConstraint!
    @IBOutlet weak var constraintHeightData    : NSLayoutConstraint!
    
    
    
    var controllerCategories                    : CategoriesViewController!
    var controllerAchievements                  : AchievementsUserViewController!
    var currenteIndexSection                    : Int = 0
    var objUser : UserBE?{
        
        didSet{
            self.updateInfo()
        }
    }
    
    
    func updateInfo(){
        
        if let user = self.objUser{
            
            self.lblNameUser?.text = "\(user.user_first_name!) \(user.user_last_name!)"
            self.btnMail?.setTitle("\(user.user_username)@belatrixsf.com", for: .normal)
            self.btnSkype?.setTitle(user.user_skype_id!, for: .normal)
            self.btnLocation?.setTitle(user.user_location!.location_name, for: .normal)
            self.lblScore?.text = "\(user.user_total_score)"
            self.lblLevel?.text = "\(user.user_level)"
            
            self.imgUser?.objUser = self.objUser
            
        }
    }
    
    //MARK: - UIScrollViewDelegate
    
    func transitionViewSectionInto(_ scrollView : UIScrollView) {
        
        if Int(scrollView.contentOffset.x) % Int(scrollView.frame.size.width) != 0 {
            
            let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            let delta = scrollView.contentOffset.x / scrollView.frame.size.width
            var alpha : CGFloat = 1.0
        
            if index < self.currenteIndexSection {
                alpha = CGFloat(self.currenteIndexSection) - delta
            }else{
                alpha = delta - CGFloat(self.currenteIndexSection)
            }
            
            let currenteView = self.arrayVistas[self.currenteIndexSection]
            
            for view in self.arrayVistas{
                view.alpha = currenteView == view ? (1 - alpha) : alpha
            }
            
        }else {
            self.currenteIndexSection = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
       self.transitionViewSectionInto(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.transitionViewSectionInto(scrollView)
        self.animateUnderlineSection(self.arrayButtonsSection[self.currenteIndexSection])
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.transitionViewSectionInto(scrollView)
        self.animateUnderlineSection(self.arrayButtonsSection[self.currenteIndexSection])
    }
    
    //MARK: - Aux
    
    func animateUnderlineSection(_ sender: UIButton){
        
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            for button in self.arrayButtonsSection{
                let color = button == sender ? Constants.MAIN_COLOR : UIColor.lightGray
                button.setTitleColor(color, for: .normal)
            }
            
            self.constraintSectionSelected.constant = sender.tag == 0 ? -(UIScreen.main.bounds.size.width / 4) : UIScreen.main.bounds.size.width / 4
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    //MARK: - Actions
    
    @IBAction func tapShowImageProfile(_ sender: Any) {
        
        if self.objUser?.user_avatar.count != 0 {
            self.performSegue(withIdentifier: "ImageProfileViewController", sender: nil)
        }
        
    }
    
    @IBAction func clickBtnBack(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clicBtnSection(_ sender: UIButton) {
        
        self.currenteIndexSection = sender.tag
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            for button in self.arrayButtonsSection{
                let color = button == sender ? Constants.MAIN_COLOR : UIColor.lightGray
                button.setTitleColor(color, for: .normal)
            }
            
            self.constraintSectionSelected.constant = sender.tag == 0 ? -(UIScreen.main.bounds.size.width / 4) : UIScreen.main.bounds.size.width / 4
            
            for view in self.arrayVistas {
                view.alpha = 0
            }
            
            self.arrayVistas[sender.tag].alpha = 1
            self.scrollContent.setContentOffset(CGPoint(x: self.scrollContent.frame.size.width * CGFloat(sender.tag), y: 0), animated: false)
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)

    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.imgUser?.setInitialVisualConfiguration()
        self.imgUser?.borderImage = 5
        
        if self.objUser == nil {
            self.objUser = UserBE.shareInstance
            
        }
        
        self.clicBtnSection(self.arrayButtonsSection[0])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.updateInfo()
        
        UserBC.getUserInformationById(self.objUser!.user_pk, withSuccessful: { (objUser) in
            
            objUser.user_color = self.objUser?.user_color ?? UIColor.darkGray
            
            if SessionBE.sharedInstance?.session_user_id == objUser.user_pk {
                UserBE.shareInstance = objUser
            }
        
            self.objUser = objUser
            
        }) { (title, message) in
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if self.objUser == nil {
            self.objUser = UserBE.shareInstance
        }
        
        if segue.identifier == "CategoriesViewController" {
            
            self.controllerCategories = segue.destination as! CategoriesViewController
            self.controllerCategories.objUser = self.objUser!
            
        }else if segue.identifier == "AchievementsUserViewController" {
            
            self.controllerAchievements = segue.destination as! AchievementsUserViewController
            self.controllerAchievements.objUser = self.objUser!
            
        }else if segue.identifier == "ImageProfileViewController" {
            
            let controller = segue.destination as! ImageProfileViewController
            controller.objUser = self.objUser
        }
    }
    

}
