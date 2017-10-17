//
//  CreateNewAccountViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 24/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class CreateNewAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var constraintBottomViewLogo : NSLayoutConstraint!
    @IBOutlet weak var constraintTopViewLogo    : NSLayoutConstraint!
    @IBOutlet weak var constraintCenterForm     : NSLayoutConstraint!
    @IBOutlet weak var viewLogo                 : UIView!
    @IBOutlet weak var viewFormUser             : UIView!
    @IBOutlet weak var txtUserName              : UITextField!
    @IBOutlet weak var activityPassword         : UIActivityIndicatorView!
    @IBOutlet weak var lblDomain                : UILabel!
    
    
    var initialValueConstraintCenterForm        : CGFloat = 0
    var initialPlaceHolderUser                  : String!
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.txtUserName{
            self.txtUserName.placeholder = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.txtUserName{
            self.txtUserName.placeholder = self.txtUserName.text?.characters.count == 0 ? self.initialPlaceHolderUser : ""
        }
    }
    
    //MARK: -
    
    func starLoading(){
        
        self.view.isUserInteractionEnabled = false
        self.activityPassword.startAnimating()
    }
    
    func stopLoading(){
        
        self.view.isUserInteractionEnabled = true
        self.activityPassword.stopAnimating()
    }
    
    //MARK: - IBAction methods
    
    @IBAction func clickBtnBack(_ sender: Any?) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickBtnPassword(_ sender: Any?) {
        
        self.tapToCloseKeyboard(nil)
        
        self.activityPassword.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        UserBC.createUserWithEmail(self.txtUserName.text, withSuccessful: { (isCorrect) in
            
            self.activityPassword.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            if isCorrect {
                
                CDMUserAlerts.showSimpleAlert(title: "app_name".localized, withMessage: "sent_mail_correct".localized, withAcceptButton: "Accept".localized, withController: self, withCompletion:nil)
                
            }else{
                CDMUserAlerts.showSimpleAlert(title: "generic_title_problem".localized, withMessage: "sent_mail_incorrect".localized, withAcceptButton: "Accept".localized, withController: self, withCompletion: nil)
            }
            
        }) { (title, messageError) in
            
            self.activityPassword.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            CDMUserAlerts.showSimpleAlert(title: title, withMessage: messageError, withAcceptButton: "Accept".localized, withController: self, withCompletion: nil)
        }
    }
    
    @IBAction func changeText(_ sender: Any) {
        
        self.txtUserName.invalidateIntrinsicContentSize()
    }
    
    @IBAction func tapToCloseKeyboard(_ sender: Any?) {
        
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let result = string.replace(" ", withString: "")
        return result.characters.count == string.characters.count
    }
    
    //MARK: - Keyboard Notifications
    
    @objc func keyboardWillShown(notification : NSNotification) -> Void{
        
        let kbSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        let finalForm = self.viewFormUser.frame.size.height / 2 + self.initialValueConstraintCenterForm
        let sizeScreen = UIScreen.main.bounds.size.height / 2
        let availableArea = sizeScreen - (kbSize?.height)!
        
        if finalForm > availableArea {
            
            UIView.animate(withDuration: 0.35, animations: {
                
                self.constraintCenterForm.constant = self.initialValueConstraintCenterForm - (finalForm - availableArea) - 2
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @objc func keyboardWillBeHidden(notification : NSNotification) -> Void {
        
        UIView.animate(withDuration: 0.35, animations: {
            
            self.constraintCenterForm.constant = self.initialValueConstraintCenterForm
            self.view.layoutIfNeeded()
        })
    }
    
    //MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialValueConstraintCenterForm = self.constraintCenterForm.constant
        self.initialPlaceHolderUser = self.txtUserName.placeholder
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.lblDomain.text = "@" + AppInformationBC.sharedInstance.appInformation.appInformation_emailDomain
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
