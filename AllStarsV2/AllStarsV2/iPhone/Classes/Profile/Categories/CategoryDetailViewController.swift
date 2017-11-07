//
//  CategoryDetailViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 3/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StarUserTableViewCellDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var constraintTopContent     : NSLayoutConstraint!
    @IBOutlet weak var constraintTopTitle       : NSLayoutConstraint!
    @IBOutlet weak var constraintMiddleTitle    : NSLayoutConstraint!
    @IBOutlet weak var constraintBottomTitle    : NSLayoutConstraint!
    @IBOutlet weak var constraintTopHeader      : NSLayoutConstraint!
    @IBOutlet weak var constraintHeightHeader   : NSLayoutConstraint!
    @IBOutlet weak var viewHeader               : UIView!
    @IBOutlet weak var btnBack                  : UIButton!
    @IBOutlet weak var tlbStars                 : UITableView!
    @IBOutlet weak var loadingView              : CDMLoadingView!
    
    var fontTitleInitial    : UIFont!
    var titleColorInitial   : UIColor!
    var objCategory         : CategoryBE!
    var arrayStars          = [StarUserBE]()
    var objUser             : UserBE!
    var cellSelected        : StarUserTableViewCell!
    
    @IBAction func clickBtnBack(_ sender: Any?) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
    
    //MARK: - StarUserTableViewCellDelegate
    
    func starUserTableViewCell(_ cell: StarUserTableViewCell, selectStar objStar: StarUserBE) {
        
        let indexPath = self.tlbStars.indexPath(for: cell)
        self.tlbStars.reloadRows(at: [indexPath!], with: .fade)
        
    }
    
    func starUserTableViewCell(_ cell: StarUserTableViewCell, selectNameUserFrom objUser: UserBE) {
        
        self.cellSelected = cell
        self.performSegue(withIdentifier: "UserProfileViewController", sender: objUser)
    }
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayStars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let objStar = self.arrayStars[indexPath.row]
        
        let cellIdentifier = objStar.star_comment.count == 0 ? "StarUserTableViewCell1" : "StarUserTableViewCell2"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StarUserTableViewCell
        
        cell.delegate = self
        cell.objStar = objStar
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getStarsToCategory(){
        
        self.loadingView.iniciarLoading(conMensaje: "get_stars_category_list", conAnimacion: true)
        
        CategoryBC.listStartsToCategory(self.objCategory, toUser: self.objUser, withSuccessful: { (arrayStars) in
            
            self.arrayStars = arrayStars
            self.tlbStars.reloadSections(IndexSet(integer: 0), with: .automatic)
            
            self.loadingView.detenerLoading()
            
        }) { (title, message) in
            
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fontTitleInitial = self.lblTitle.font
        self.titleColorInitial = self.lblTitle.textColor
        
        self.tlbStars.estimatedRowHeight = 30
        self.tlbStars.rowHeight = UITableViewAutomaticDimension
        self.getStarsToCategory()
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
        
        if segue.identifier == "UserProfileViewController" {
            
            let controller = segue.destination as! UserProfileViewController
            controller.allowRevealController = false
            controller.objUser = sender as? UserBE
        }
    }
    

}
