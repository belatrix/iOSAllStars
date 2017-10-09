//
//  KudosUserViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 25/09/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class KudosUserViewController: UIViewController, SelectCategoryKudosViewControllerDelegate, SelectKeywordViewControllerDelegate {

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
    @IBOutlet weak var constraintBottomScroll   : NSLayoutConstraint!
    @IBOutlet weak var btnAction                : UIButton!
    @IBOutlet weak var btnTag                   : UIButton!
    @IBOutlet weak var activityAction           : UIActivityIndicatorView!
    @IBOutlet weak var activityTag              : UIActivityIndicatorView!
    @IBOutlet weak var txtComments: UITextView!
    
    
    var objUser             : UserBE!
    var arrayCategories     = [CategoryBE]()
    var arrayKeyWords       = [KeywordBE]()
    var objCategorySelected : CategoryBE?
    var objKeywordSelected  : KeywordBE?
    
    @IBAction func tapCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func clickBtnBack(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - SelectKeywordViewControllerDelegate
    
    func selectKeywordViewController(_ controller: SelectKeywordViewController, selectKeyword keyword: KeywordBE) {
        
        self.objKeywordSelected = keyword
        self.btnTag.setTitle(keyword.keyword_name, for: .normal)
    }
    
    func selectKeywordViewController(_ controller: SelectKeywordViewController, addKeyword keyword: KeywordBE) {
        
        self.objKeywordSelected = keyword
        self.arrayKeyWords.append(keyword)
        self.arrayKeyWords = self.arrayKeyWords.sorted(by: {return $0.keyword_name > $1.keyword_name})
    }
    
    
    //MARK: - SelectCategoryKudosViewControllerDelegate
    
    func selectionCategoryKudosViewController(_ controller: SelectCategoryKudosViewController, selectCategory category: CategoryBE) {
        
        self.objCategorySelected = category
        self.btnAction.setTitle(category.category_name, for: .normal)
    }
    
    
    //MARK: - Keyboard Notifications
    
    @objc func keyboardWillShown(notification : NSNotification) -> Void{
        
        let kbSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        UIView.animate(withDuration: 0.35) {
        
            self.constraintBottomScroll.constant = kbSize!.size.height - 50
            self.view.layoutIfNeeded()
        }
    }
    
    
    @objc func keyboardWillBeHidden(notification : NSNotification) -> Void {
        
        UIView.animate(withDuration: 0.35, animations: {

            self.constraintBottomScroll.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    //MARK: - Web service
    
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
        
        self.txtComments.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15)
        self.txtComments.layer.cornerRadius = 4
        self.txtComments.layer.borderColor = UIColor.lightGray.cgColor
        self.txtComments.layer.borderWidth = 1

        
        self.lblUserName.text = "\(self.objUser.user_first_name!) \(self.objUser.user_last_name!)"
        self.lblUserLevel.text = "Level: \(self.objUser.user_level)"
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShown(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
            controller.arrayKeywordsTable = self.arrayKeyWords
            controller.objKeywordSelected = self.objKeywordSelected
            controller.delegate = self
        }
    }
    

}
