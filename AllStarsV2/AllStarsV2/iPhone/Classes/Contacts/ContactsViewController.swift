//
//  ContactsViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 11/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class ContactsViewController: SWFrontGenericoViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var srcContacts              : UISearchBar!
    @IBOutlet weak var clvContacts              : UICollectionView!
    @IBOutlet weak var constraintHeightHeader   : NSLayoutConstraint!
    
    
    var arrayContacts                           = [UserBE]()
    var nextPage                                = ""
    var requestSearch                           : URLSessionDataTask?
    var isDownload                              = false
    var cellSelected                            : ContactCollectionViewCell!
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.requestSearch?.cancel()
        self.isDownload = false
        self.nextPage = ""
        self.listFirstPageContacts(withSearchText: searchText)
    }
    
    
    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arrayContacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifer = "ContactCollectionViewCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer, for: indexPath) as! ContactCollectionViewCell
        cell.objContact = self.arrayContacts[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.cellSelected = collectionView.cellForItem(at: indexPath) as! ContactCollectionViewCell
        self.performSegue(withIdentifier: "UserProfileViewController", sender: self.arrayContacts[indexPath.row])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let numberOfElements: CGFloat = 4
        let widthCell = (UIScreen.main.bounds.size.width - (numberOfElements + 1)*10) / numberOfElements
        let heightCell = widthCell + 40
        
        return CGSize(width: widthCell, height: heightCell)
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (self.nextPage.characters.count != 0 && self.isDownload == false && scrollView.contentOffset.y + scrollView.frame.size.height  > scrollView.contentSize.height + 40) {
            
            self.listAnyPageContacts()
        }
    }
    
    
    
    
    func listFirstPageContacts(withSearchText searchText : String){
        
        if isDownload == true{
            return
        }
        
        self.isDownload = true
        
        self.requestSearch = ContactBC.listEmployee(withSearchText: searchText, withSuccessful: { (arrayContacts, nextPage) in
            
            self.isDownload = false
            self.nextPage = nextPage
        
            self.arrayContacts = arrayContacts
            
            self.clvContacts.performBatchUpdates({
                self.clvContacts.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
            
        }) { (title, message) in
            
            self.isDownload = false
        }
    }
    
    func listAnyPageContacts(){
        
        if isDownload == true{
            return
        }
        self.isDownload = true
        
        self.requestSearch = ContactBC.listEmployeeToPage(self.nextPage, withSuccessful: { (arrayContacts, nextPage) in
            
            self.isDownload = false
            self.nextPage = nextPage
            
            var arrayIndexPath = [IndexPath]()
            
            for i in self.arrayContacts.count..<(self.arrayContacts.count + arrayContacts.count){
                arrayIndexPath.append(IndexPath(item: i, section: 0))
            }
            
            self.arrayContacts.append(contentsOf: arrayContacts)
            
            self.clvContacts.performBatchUpdates({
                self.clvContacts.insertItems(at: arrayIndexPath)
            }, completion: nil)
            
        }) { (title, message) in
            
            self.isDownload = false
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.srcContacts.backgroundImage = UIImage()
        self.srcContacts.backgroundColor = UIColor.white
        self.srcContacts.barTintColor = UIColor.white
        self.constraintHeightHeader.constant = 64
        
        self.listFirstPageContacts(withSearchText: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {

        UIView.animate(withDuration: 0.7, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.constraintHeightHeader.constant = 120
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
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
        
        if segue.identifier == "UserProfileViewController" {
            
            let controller = segue.destination as! UserProfileViewController
            controller.objUser = sender as? UserBE
        }
    
    }
    

}
