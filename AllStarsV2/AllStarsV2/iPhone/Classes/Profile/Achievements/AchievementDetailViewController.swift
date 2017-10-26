//
//  AchievementDetailViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 9/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AchievementDetailViewController: UIViewController {

    @IBOutlet weak var imgIcon                  : UIImageView!
    @IBOutlet weak var constraintLeftBtnCerrar  : NSLayoutConstraint!
    @IBOutlet weak var lblName                  : UILabel!
    @IBOutlet weak var lblDescription           : UILabel!
    @IBOutlet weak var constraintTopContent     : NSLayoutConstraint!
    @IBOutlet weak var constraintBottomShare    : NSLayoutConstraint!
    @IBOutlet weak var viewContent              : UIView!
    
    
    var objAchievement : AchievementBE!
    var initialContraintTopContent : CGFloat = 0.0
    var initialCOnstraintBottomShare : CGFloat = 0.0
    
    
    
    @IBAction func clickBtnBack(_ sender: Any?) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickBtnShare(_ sender: Any) {
     
        let data = self.objAchievement.achievement_badge.badge_description.data(using: .utf8)!
        let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialContraintTopContent = self.constraintTopContent.constant
        self.initialCOnstraintBottomShare = self.constraintBottomShare.constant
        
        self.lblName.text = self.objAchievement.achievement_badge.badge_name
        self.lblDescription.text = self.objAchievement.achievement_badge.badge_description
        
        CDMImageDownloaded.descargarImagen(enURL: self.objAchievement.achievement_badge.badge_icon, paraImageView: self.imgIcon, conPlaceHolder: #imageLiteral(resourceName: "userPlaceHolder")) { (isCorrect, urlImage, image) in
            
            self.imgIcon.image = image
        }
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
