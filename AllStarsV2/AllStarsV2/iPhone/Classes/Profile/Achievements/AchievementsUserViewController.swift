//
//  AchievementsUserViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 9/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AchievementsUserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var clvAchievements  : UICollectionView!
    @IBOutlet weak var loadingView      : CDMLoadingView!
    
    
    var arrayAchievements = [AchievementBE]()
    var achievementCellSelected : AchievementCollectionViewCell!
    var objUser : UserBE?
    
    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arrayAchievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "AchievementCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AchievementCollectionViewCell
        
        cell.objAchievement = self.arrayAchievements[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.achievementCellSelected = collectionView.cellForItem(at: indexPath) as! AchievementCollectionViewCell
        self.performSegue(withIdentifier: "AchievementDetailViewController", sender: self.arrayAchievements[indexPath.row])
    }
    
    //MARK: - WebService
    
    func listAchievementsUser(){
        
        if self.arrayAchievements.isEmpty == true {
            self.loadingView.iniciarLoading(conMensaje: "get_achievements_list", conAnimacion: true)
        }
        
        AchievementBC.listAchievementsToUser(self.objUser!, withSuccessful: { (arrayAchievements) in
            
            if arrayAchievements.count > 0 {
                self.arrayAchievements = arrayAchievements
                self.clvAchievements.reloadSections(IndexSet(integer: 0))
                
                self.loadingView.detenerLoading()
            }
            else {
                self.loadingView.mostrarError(conMensaje: "no_achievements".localized, conOpcionReintentar: false)
            }
            
        }) { (title, message) in
            
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
        }
    }
    
    //MARK: -
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        if self.objUser != nil {
            self.listAchievementsUser()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AchievementDetailViewController" {
            let controller = segue.destination as! AchievementDetailViewController
            controller.objAchievement = sender as! AchievementBE
        }
    }
    

}
