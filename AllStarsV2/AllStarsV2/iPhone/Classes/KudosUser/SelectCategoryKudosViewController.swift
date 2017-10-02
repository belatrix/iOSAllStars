//
//  SelectCategorieKudosViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 25/09/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit


protocol SelectCategoryKudosViewControllerDelegate {
    func selectionCategoryKudosViewController(_ controller: SelectCategoryKudosViewController, selectCategory category: CategoryBE)
}


class SelectCategoryKudosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var blurView                 : UIVisualEffectView!
    @IBOutlet weak var constraintTopHeader      : NSLayoutConstraint!
    @IBOutlet weak var tlbCategories            : UITableView!
    @IBOutlet weak var constraintTopTlbKeywords : NSLayoutConstraint!
    
    var delegate                                : SelectCategoryKudosViewControllerDelegate!
    var arrayCategories                         = [CategoryBE]()
    var objCategorySelected                     : CategoryBE?
    
    
    @IBAction func clickBtnAtras(_ sender: Any) {
        
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.4, animations: {
            
            self.constraintTopHeader.constant = -120
            self.constraintTopTlbKeywords.constant = UIScreen.main.bounds.size.height - 120
            self.blurView.alpha = 0
            self.tlbCategories.alpha = 0
            self.view.layoutIfNeeded()
            
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SelectCategoryTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SelectCategoryTableViewCell
        cell.objCategory = self.arrayCategories[indexPath.row]
    
        if self.arrayCategories[indexPath.row] == self.objCategorySelected {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            cell.selectCell(true)
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
            cell.selectCell(false)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SelectCategoryTableViewCell
        cell.selectCell(true)
        self.delegate.selectionCategoryKudosViewController(self, selectCategory: self.arrayCategories[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SelectCategoryTableViewCell
        cell.selectCell(false)
    }
    

    func getCategoryByCategoryReference(_ category: CategoryBE?) -> CategoryBE? {
        
        if category == nil {
            return nil
        }
        
        let arrayResult = self.arrayCategories.filter({$0.category_pk == category!.category_pk})
        return arrayResult.count == 0 ? nil : arrayResult[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objCategorySelected = self.getCategoryByCategoryReference(self.objCategorySelected)
        
        self.tlbCategories.estimatedRowHeight = 55
        self.tlbCategories.rowHeight = UITableViewAutomaticDimension
        
        self.constraintTopHeader.constant = -120
        self.constraintTopTlbKeywords.constant = UIScreen.main.bounds.size.height - 120
        self.blurView.alpha = 0
        self.tlbCategories.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        self.tlbCategories.reloadData()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            self.constraintTopHeader.constant = 0
            self.constraintTopTlbKeywords.constant = 0
            self.blurView.alpha = 1
            self.tlbCategories.alpha = 1
            self.view.layoutIfNeeded()
            
        }, completion: nil)
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
