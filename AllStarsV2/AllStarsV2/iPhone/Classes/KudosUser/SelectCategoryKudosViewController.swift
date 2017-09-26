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


class SelectCategoryKudosViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var constraintBottomPicker   : NSLayoutConstraint!
    @IBOutlet weak var constraintHeightContainer: NSLayoutConstraint!
    @IBOutlet weak var pickerCategory           : UIPickerView!
    
    var delegate                                : SelectCategoryKudosViewControllerDelegate!
    var arrayCategories                         = [CategoryBE]()
    var objCategorySelected                     : CategoryBE?
    
    //MARK: - UIPickerViewDelegate, UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.arrayCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.arrayCategories[row].category_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row <= self.arrayCategories.count{
            self.delegate.selectionCategoryKudosViewController(self, selectCategory: self.arrayCategories[row])
        }
    }
    
    @IBAction func tapClose(_ sender: Any) {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.backgroundColor = .clear
            self.constraintBottomPicker.constant = -self.pickerCategory.frame.size.height
            self.view.layoutIfNeeded()
            
        }) { (_) in
            
            self.dismiss(animated: false, completion: nil)
        }
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
        
        self.view.backgroundColor = .clear
        self.constraintBottomPicker.constant = -self.constraintHeightContainer.constant
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.constraintBottomPicker.constant = 0
            self.view.layoutIfNeeded()
        }
        
        self.objCategorySelected = self.getCategoryByCategoryReference(self.objCategorySelected)

        if self.objCategorySelected == nil && self.arrayCategories.count != 0 {
            self.delegate.selectionCategoryKudosViewController(self, selectCategory: self.arrayCategories[0])
            
        }else if self.objCategorySelected != nil {
            self.pickerCategory.selectRow(self.arrayCategories.index(of: self.objCategorySelected!)!, inComponent: 0, animated: false)
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
