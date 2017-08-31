//
//  SelectLocationViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 31/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

protocol SelectLocationViewControllerDelegate {
    func selectionLocationViewController(_ controller: SelectLocationViewController, selectLocation location: LocationBE)
}

class SelectLocationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var constraintBottomPicker   : NSLayoutConstraint!
    @IBOutlet weak var constraintHeightContainer: NSLayoutConstraint!
    @IBOutlet weak var pickerLocation           : UIPickerView!
    
    var delegate                                : SelectLocationViewControllerDelegate!
    var arrayLocations                          = [LocationBE]()
    var objLocationSelected                     : LocationBE?
    
    //MARK: - UIPickerViewDelegate, UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.arrayLocations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.arrayLocations[row].location_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.delegate.selectionLocationViewController(self, selectLocation: self.arrayLocations[row])
    }
    
    @IBAction func tapClose(_ sender: Any) {
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.backgroundColor = .clear
            self.constraintBottomPicker.constant = -self.pickerLocation.frame.size.height
            self.view.layoutIfNeeded()
            
        }) { (_) in
            
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func getLocationByLocationReference(_ location: LocationBE?) -> LocationBE? {
        
        if location == nil {
            return nil
        }
        
        let arrayResult = self.arrayLocations.filter({$0.location_pk == location!.location_pk})
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
        
        self.objLocationSelected = self.getLocationByLocationReference(self.objLocationSelected)
        
        if self.objLocationSelected == nil && self.arrayLocations.count != 0 {
            self.delegate.selectionLocationViewController(self, selectLocation: self.arrayLocations[0])
        }else{
            
            self.pickerLocation.selectRow(self.arrayLocations.index(of: self.objLocationSelected!)!, inComponent: 0, animated: false)
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
