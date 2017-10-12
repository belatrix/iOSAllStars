//
//  EditProfileViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 26/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, SelectLocationViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var constraintHeightBlur     : NSLayoutConstraint!
    @IBOutlet weak var constraintBottomContent  : NSLayoutConstraint!
    @IBOutlet weak var constraintContentHeight  : NSLayoutConstraint!
    @IBOutlet weak var constraintHeightHeader   : NSLayoutConstraint!
    @IBOutlet weak var constraintBottomScroll   : NSLayoutConstraint!
    @IBOutlet weak var constraintTopScroll      : NSLayoutConstraint!
    @IBOutlet weak var constraintTopHeader      : NSLayoutConstraint!
    @IBOutlet weak var constraintBottomSave     : NSLayoutConstraint!
    @IBOutlet weak var imgUser                  : ImageUserProfile!
    @IBOutlet weak var imgBackgroundUser        : UIImageView!
    @IBOutlet weak var viewImgUser              : UIView!
    @IBOutlet weak var txtName                  : UITextFieldCustom!
    @IBOutlet weak var txtLastname              : UITextFieldCustom!
    @IBOutlet weak var txtSkype                 : UITextFieldCustom!
    @IBOutlet weak var btnLocations             : UIButton!
    @IBOutlet weak var btnSave                  : UIButton!
    @IBOutlet weak var activityLocations        : UIActivityIndicatorView!
    @IBOutlet weak var activitySave             : UIActivityIndicatorView!
    @IBOutlet weak var btnTakePhoto             : UIButton!
    @IBOutlet weak var viewPhotoContainer       : UIView!
    
    
    var initialValueConstraintHeightBlur        : CGFloat!
    var arrayLocations                          = [LocationBE]()
    
    var objUser                                 = UserBE() {
        
        didSet{
            
            self.txtSkype.text = objUser.user_skype_id!
            self.txtLastname.text = objUser.user_last_name!
            self.txtName.text = objUser.user_first_name!
            
            CDMImageDownloaded.descargarImagen(enURL: self.objUser.user_avatar, paraImageView: self.imgBackgroundUser, conPlaceHolder: self.imgBackgroundUser.image) { (isCorrect, urlImage, image) in
                self.imgBackgroundUser.image = image
            }
            
            if let objLocationReference = objUser.user_location {
                self.btnLocations.setTitle(objLocationReference.location_name, for: .normal)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: {
            
            let imagenNueva = info["UIImagePickerControllerOriginalImage"] as! UIImage
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.imgUser.image = imagenNueva
                self.imgBackgroundUser.image = imagenNueva
                
            })
            
        })
    }
    
    //MARK: - IBAction
    
    @IBAction func clickBtnBack(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickBtnLocations(_ sender: Any?) {
        
        self.tapCloseKeyboard(nil)
    }
    
    @IBAction func tapCloseKeyboard(_ sender: Any?) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func clickBtnChangePhoto(_ sender: Any) {
        
        CDMUserAlerts.showActionSheet(withTitle: "", withMessage: "select_type_photo".localized, withButtons: ["library".localized, "camera".localized], withCancelButton: "cancel".localized, inController: self, withSelectionButtonIndex: { (index) in
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = index == 0 ? UIImagePickerControllerSourceType.savedPhotosAlbum : UIImagePickerControllerSourceType.camera
            self.present(picker, animated: true, completion: nil)
            
        }, withActionCancel: nil)
        
    }
    
    @IBAction func clickBtnSave(_ sender: UIButton) {
        
        self.objUser.user_first_name = self.txtName.text
        self.objUser.user_last_name = self.txtLastname.text
        self.objUser.user_skype_id = self.txtSkype.text

        self.updateUserInfo()
        
    }
    
    //MARK: - SelectLocationViewControllerDelegate
    
    func selectionLocationViewController(_ controller: SelectLocationViewController, selectLocation location: LocationBE) {
        
        self.objUser.user_location = location
        self.btnLocations.setTitle(location.location_name, for: .normal)
    }
    
    
    
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.txtName {
            self.txtLastname.becomeFirstResponder()
        }else if textField == self.txtLastname {
            self.txtSkype.becomeFirstResponder()
        }else if textField == self.txtSkype {
            self.clickBtnLocations(nil)
            self.performSegue(withIdentifier: "SelectLocationViewController", sender: nil)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        (textField as! UITextFieldCustom).deselectTextField()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        (textField as! UITextFieldCustom).selectTextField()
    }
    
    
    
    
    //MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = self.initialValueConstraintHeightBlur - scrollView.contentOffset.y <= 0 ? 0 :self.initialValueConstraintHeightBlur - scrollView.contentOffset.y
        self.constraintHeightBlur.constant = height
        let delta = height - self.initialValueConstraintHeightBlur
        
        if delta < 0 {
            self.viewImgUser.transform = CGAffineTransform(scaleX: 1, y: 1)
        }else{
            let deltaPercent = height / self.initialValueConstraintHeightBlur
            self.viewImgUser.transform = CGAffineTransform(scaleX: deltaPercent, y: deltaPercent)
        }
    }
    
    
    
    //MARK: - WebService
    
    func updateUserInfo(){
        
        self.activitySave.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        UserBC.updateInfoToUser(self.objUser, withImage: self.imgUser.image, withSuccessful: { (objUserResult) in
            
            self.activitySave.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            objUserResult.user_color = self.objUser.user_color

            self.uploadPhotoWithUserResult(objUserResult)
                    
        }) { (title, body) in
            
            self.activitySave.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            CDMUserAlerts.showSimpleAlert(title: title, withMessage: body, withAcceptButton: "ok".localized, withController: self, withCompletion: nil)
        }
    }
    
    func canPerformSegueWithIdentifier(_ identifier : String) -> Bool {
        
        let templates = self.value(forKey: "storyboardSegueTemplates") as! NSArray
        let predicate = NSPredicate(format: "identifier == %@", identifier)
        let result = templates.filtered(using: predicate)
        return (result.count>0)
    }
    
    func goToNextController(){
        
        if self.canPerformSegueWithIdentifier("RevealViewController"){
            self.performSegue(withIdentifier: "RevealViewController", sender: nil)
        }else{
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func uploadPhotoWithUserResult(_ objUserResult : UserBE){
        
        self.activitySave.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        UserBC.uploadPhoto(self.imgUser.image!, withSuccessful: { (objUser) in
            
            self.activitySave.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            self.objUser = objUser
            objUser.user_color = self.objUser.user_color
            UserBE.shareInstance = objUser
            self.imgUser.objUser = objUser
            
            self.goToNextController()

        }, withAlertInformation: { (title, message) in
          
            self.activitySave.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            self.goToNextController()
        })
    }
    
    func getUserInformation(){
        
        self.activitySave.startAnimating()
        self.btnSave.isEnabled = false
        
        UserBC.getUserInformationById(self.objUser.user_pk, withSuccessful: { (objUser) in
            
            objUser.user_color = self.objUser.user_color
            self.activitySave.stopAnimating()
            self.btnSave.isEnabled = true
            self.objUser = objUser
            self.imgUser.objUser = objUser
            UserBE.shareInstance = objUser
            
        }) { (title, message) in
            
            self.activitySave.stopAnimating()
            self.btnSave.isEnabled = true
        }
    }
    
    func listLocations(){
        
        self.btnLocations.setTitle("--", for: .normal)
        self.btnLocations.isEnabled = false
        self.activityLocations.startAnimating()
        
        LocationBC.listLocations(withSuccessful: { (arrayLocations) in
          
            self.btnLocations.isEnabled = true
            self.activityLocations.stopAnimating()
            
            self.arrayLocations = arrayLocations
            
        }) { (title, message) in
            
            self.btnLocations.isEnabled = false
            self.activityLocations.stopAnimating()
        }
        
    }
    
    
    
    
    //MARK: - Keyboard Notifications
    
    @objc func keyboardWillShown(notification : NSNotification) -> Void{
        
        if let kbSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            UIView.animate(withDuration: 0.35, animations: {
                
                self.constraintBottomScroll.constant = kbSize.height
                self.constraintBottomContent.constant = 20
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    @objc func keyboardWillBeHidden(notification : NSNotification) -> Void {
        
        UIView.animate(withDuration: 0.35, animations: {
            
            self.constraintBottomScroll.constant = 44
            
            let delta = UIScreen.main.bounds.size.height - self.constraintHeightHeader.constant - self.constraintContentHeight.constant - self.constraintHeightBlur.constant - self.btnSave.bounds.size.height
            self.constraintBottomContent.constant = delta > 0 ?  delta + 1 : 20
            
            self.view.layoutIfNeeded()
        })
    }
    
    //MARK: -

    override func viewDidLoad() {

        super.viewDidLoad()
        
        self.imgUser.setInitialVisualConfiguration()
        self.imgUser.borderImage = 5
        
        
        if let objUser = UserBE.shareInstance{
            self.objUser = objUser
            self.imgUser.objUser = self.objUser
        }else {
            
            if let id = SessionBE.sharedInstance?.session_user_id{
                self.objUser.user_pk = id.intValue
            }
        }
        
        self.initialValueConstraintHeightBlur = self.constraintHeightBlur.constant
        let delta = UIScreen.main.bounds.size.height - self.constraintHeightHeader.constant - self.constraintContentHeight.constant - self.constraintHeightBlur.constant - self.btnSave.bounds.size.height
        if delta > 0 {
            self.constraintBottomContent.constant = delta + 1
        }
    
        self.txtName.makeBorder()
        self.txtLastname.makeBorder()
        self.txtSkype.makeBorder()
        self.btnLocations.makeBorder()
    
        self.listLocations()
        self.getUserInformation()
    }

    override func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SelectLocationViewController" {
        
            let controller = segue.destination as! SelectLocationViewController
            controller.arrayLocations = self.arrayLocations
            controller.objLocationSelected = self.objUser.user_location
            controller.delegate = self
        }
    }

}


