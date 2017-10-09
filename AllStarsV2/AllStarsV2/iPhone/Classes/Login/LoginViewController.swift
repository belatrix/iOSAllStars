//
//  LoginViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 19/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var constraintTopViewLogo    : NSLayoutConstraint!
    @IBOutlet weak var constraintBottomViewLogo : NSLayoutConstraint!
    @IBOutlet weak var constraintHeightLogo     : NSLayoutConstraint!
    @IBOutlet weak var constraintWidthLogo      : NSLayoutConstraint!
    @IBOutlet weak var constraintCenterForm     : NSLayoutConstraint!
    @IBOutlet weak var viewFormUser             : UIView!
    @IBOutlet weak var viewLogo                 : UIView!
    @IBOutlet weak var lblNameCompany           : UILabel!
    @IBOutlet weak var txtUserName              : UITextField!
    @IBOutlet weak var txtPassword              : UITextField!
    @IBOutlet weak var activityLogin            : UIActivityIndicatorView!
    
    
    
    var initialValueConstraintCenterForm        : CGFloat = 0
    var initialPlaceHolderUser                  : String!
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if self.txtUserName == textField {
            self.txtPassword.becomeFirstResponder()
        }else{
            self.clickBtnLogin(nil)
        }
        
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
    
    func startLoading(){
        self.view.isUserInteractionEnabled = false
        self.activityLogin.startAnimating()
    }
    
    func stopLoading(){
        self.view.isUserInteractionEnabled = true
        self.activityLogin.stopAnimating()
    }
    
    
    func getUserInformation(withSession objSession : SessionBE){
        
        self.startLoading()
    
        UserBC.getUserInformationById(objSession.session_user_id.intValue, withSuccessful: { (objUser) in
            
            self.stopLoading()
            UserBE.shareInstance = objUser
            self.performSegue(withIdentifier: "RevealViewController", sender: nil)
            
        }) { (title, message) in
            
            self.stopLoading()
            CDMUserAlerts.showSimpleAlert(title: title, withMessage: message, withAcceptButton: "ok".localized, withController: self, withCompletion: nil)
        }
    }
    
    
    func loginUser(){
        
        self.startLoading()
        
        UserBC.logInUsername(self.txtUserName.text, withPassword: self.txtPassword.text, withSuccessful: { (objSession) in
            
            self.stopLoading()
            self.getUserInformation(withSession: objSession)
            
        }, sessionProfileIncomplete: { (objSession) in
            
            self.stopLoading()
            self.performSegue(withIdentifier: "CompleteProfileViewController", sender: nil)
            
        }, sessionNeedResetPassword: { (objSession) in
            
            self.stopLoading()
            self.performSegue(withIdentifier: "ChangePasswordViewController", sender: objSession)
            
        }) { (title, message) in
            
            self.stopLoading()
            CDMUserAlerts.showSimpleAlert(title: title, withMessage: message, withAcceptButton: "ok".localized, withController: self, withCompletion: nil)
        }
    }
    
    //MARK: - IBAction methods
    
    @IBAction func clickBtnLogin(_ sender: Any?) {
        
        self.tapToCloseKeyboard(nil)
        self.loginUser()
    }
    
    @IBAction func changeText(_ sender: Any) {
        
        self.txtUserName.invalidateIntrinsicContentSize()
    }
    
    @IBAction func tapToCloseKeyboard(_ sender: Any?) {
        
        self.view.endEditing(true)
    }

    
    
    
    //MARK: - Keyboard Notifications
    
    @objc func keyboardWillShown(notification : NSNotification) -> Void{
        
        let kbSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        let finalForm = (self.viewFormUser.frame.size.height + 120) / 2 + self.initialValueConstraintCenterForm
        let sizeScreen = UIScreen.main.bounds.size.height / 2
        let availableArea = sizeScreen - (kbSize?.height)!
        
        if finalForm > availableArea {
            
            UIView.animate(withDuration: 0.35, animations: {
                
                self.constraintCenterForm.constant = self.initialValueConstraintCenterForm - (finalForm - availableArea)
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
        
        UIApplication.shared.statusBarStyle = .default
        
        self.initialValueConstraintCenterForm = self.constraintCenterForm.constant
        self.initialPlaceHolderUser = self.txtUserName.placeholder
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
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ChangePasswordViewController" {
            
            let controller = segue.destination as! ChangePasswordViewController
            controller.objSession = sender as! SessionBE
        }
        
    }
    
}


