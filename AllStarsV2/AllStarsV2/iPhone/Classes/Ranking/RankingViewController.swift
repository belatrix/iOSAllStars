//
//  RankingViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 17/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class RankingViewController: SWFrontGenericoViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var clvUsers                 : UICollectionView!
    
    var maxValue                                : Int = 0
    
    var arrayUsers                              = [UserBE]()
    var cellSelected                            : UserRankingCollectionViewCell!
    
    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arrayUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "UserRankingCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! UserRankingCollectionViewCell
        cell.maxValue = self.maxValue
        cell.objContact = self.arrayUsers[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.cellSelected = collectionView.cellForItem(at: indexPath) as! UserRankingCollectionViewCell
        self.performSegue(withIdentifier: "UserProfileViewController", sender: self.arrayUsers[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let numberOfElements: CGFloat = 4
        let widthCell = (UIScreen.main.bounds.size.width - (numberOfElements + 1)*10) / numberOfElements
        let heightCell = widthCell + 57
        
        return CGSize(width: widthCell, height: heightCell)
    }


    func listEmployeeRanking() {
        
        RankingBC.listEmployeeByKind(TypeKind.totalScore.rawValue, withSuccessful: { (arrayUsers) in
            
            let arrayResult = arrayUsers.sorted(by: {return $0.user_value > $1.user_value})
            self.maxValue = arrayResult.count > 0 ? arrayResult[0].user_value : 0
            
            if self.arrayUsers.count == 0{
                self.arrayUsers = arrayUsers
                self.clvUsers.reloadData()
            }else{
                
                self.arrayUsers = arrayUsers
      
                self.clvUsers.performBatchUpdates({
                    self.clvUsers.reloadSections(IndexSet(integer: 0))
                }, completion: { (_) in
                    
                })
            }
         
        }) { (title, message) in
            
        }
    }
    


    
    //MARK: - ViewController
    
    override func loadView() {
        
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        self.listEmployeeRanking()
        super.viewDidAppear(animated)
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
