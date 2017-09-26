//
//  KudosUserViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 25/09/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class KudosUserViewController: UIViewController, SelectCategoryKudosViewControllerDelegate {

    @IBOutlet weak var imgUser                  : ImageUserProfile!
    @IBOutlet weak var lblUserName              : UILabel!
    @IBOutlet weak var lblUserLevel             : UILabel!
    @IBOutlet weak var viewUserInformation      : UIView!
    @IBOutlet weak var viewOptions              : UIView!
    @IBOutlet weak var viewHeader               : UIView!
    @IBOutlet weak var constraintTopOptions     : NSLayoutConstraint!
    @IBOutlet weak var constraintBottonOptions  : NSLayoutConstraint!
    @IBOutlet weak var constraintHeightData     : NSLayoutConstraint!
    @IBOutlet weak var constraintTopHeader      : NSLayoutConstraint!
    @IBOutlet weak var btnAction                : UIButton!
    @IBOutlet weak var btnTag                   : UIButton!
    @IBOutlet weak var activityAction           : UIActivityIndicatorView!
    @IBOutlet weak var activityTag              : UIActivityIndicatorView!
    
    
    var objUser : UserBE!
    var arrayCategories = [CategoryBE]()
    var arrayKeyWords = [KeywordBE]()
    var objCategorySelected : CategoryBE?
    
    @IBAction func clickBtnBack(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    func selectionCategoryKudosViewController(_ controller: SelectCategoryKudosViewController, selectCategory category: CategoryBE) {
        
        self.objCategorySelected = category
        self.btnAction.setTitle(category.category_name, for: .normal)
    }
    
    
    func getCategories(){
        
        self.btnTag.isEnabled = false
        self.activityTag.startAnimating()
        
        CategoryBC.listGeneralCategories(withSuccessful: { (arrayCategories) in
            
            self.btnTag.isEnabled = true
            self.activityTag.stopAnimating()
            self.arrayCategories = arrayCategories
            
        }) { (title, message) in
            
            self.btnTag.isEnabled = true
            self.activityTag.stopAnimating()
        }
    }
    
    func getKeyWords(){
        
       
        self.btnAction.isEnabled = false
        self.activityAction.startAnimating()
        
        CategoryBC.listGeneralKeyWords(withSuccessful: { (arrayKeyWords) in
            
            self.btnAction.isEnabled = true
            self.activityAction.stopAnimating()
            self.arrayKeyWords = arrayKeyWords
            
        }) { (title, message) in
            
            self.btnAction.isEnabled = true
            self.activityAction.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgUser.objUser = self.objUser
        self.imgUser.setInitialVisualConfiguration()
        self.btnTag.makeBorder()
        self.btnAction.makeBorder()
        
        self.getCategories()
        self.getKeyWords()
        
        self.lblUserName.text = "\(self.objUser.user_first_name!) \(self.objUser.user_last_name!)"
        self.lblUserLevel.text = "Level: \(self.objUser.user_level)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SelectCategoryKudosViewController" {
            
            let controller = segue.destination as! SelectCategoryKudosViewController
            controller.arrayCategories = self.arrayCategories
            controller.objCategorySelected = self.objCategorySelected
            controller.delegate = self
            
        }else if segue.identifier == "SelectKeywordViewController"{
            
            let controller = segue.destination as! SelectKeywordViewController
            controller.arrayKeywords = self.arrayKeyWords
        }
    }
    

}
