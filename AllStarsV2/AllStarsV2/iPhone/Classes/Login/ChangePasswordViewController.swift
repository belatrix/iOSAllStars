//
//  ChangePasswordViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 25/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var constraintBottomViewLogo : NSLayoutConstraint!
    @IBOutlet weak var constraintTopViewLogo    : NSLayoutConstraint!
    @IBOutlet weak var constraintCenterForm     : NSLayoutConstraint!
    @IBOutlet weak var viewLogo                 : UIView!
    @IBOutlet weak var viewFormUser             : UIView!
    @IBOutlet weak var txtCurrentPassword       : UITextField!
    @IBOutlet weak var txtNewPassword           : UITextField!
    @IBOutlet weak var txtRepeatNewPassword     : UITextField!
    @IBOutlet weak var activityPassword         : UIActivityIndicatorView!
    
    var initialValueConstraintCenterForm        : CGFloat = 0
    var objSession                              : SessionBE!
    
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.txtCurrentPassword {
            self.txtNewPassword.becomeFirstResponder()
        }else if textField == self.txtNewPassword {
            self.txtRepeatNewPassword.becomeFirstResponder()
        }else if textField == self.txtRepeatNewPassword {
            self.clickBtnChangePassword(nil)
        }
        
        return true
    }
    
    
    //MARK: - WebService
    
    func changePassword(){
        
        self.starLoading()
        
        UserBC.resetUserPassword(withSession: self.objSession, currentPassword: self.txtCurrentPassword.text, newPassword: self.txtNewPassword.text, repeatNewPassword: self.txtRepeatNewPassword.text, withSuccessful: { (objSession) in
            
            self.objSession = objSession
            self.stopLoading()
            
            if self.objSession.session_base_profile_complete == false{
                
                self.performSegue(withIdentifier: "CompleteProfileViewController", sender: nil)
            }else{
                
                UserBC.saveSession(self.objSession)
                //TODO: mostrar aplicacion
            }
            
        }) { (title, message) in
            
            self.stopLoading()
            CDMUserAlerts.showSimpleAlert(title: title, withMessage: message, withAcceptButton: "ok".localized, withController: self, withCompletion: nil)
            
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
    
    @IBAction func clickBtnChangePassword(_ sender: Any?) {
        
        self.tapToCloseKeyboard(nil)
        self.changePassword()
    }
    
    @IBAction func tapToCloseKeyboard(_ sender: Any?) {
        
        self.view.endEditing(true)
    }
    
    //MARK: - Keyboard Notifications
    
    @objc func keyboardWillShown(notification : NSNotification) -> Void{
        
        let kbSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
