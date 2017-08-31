//
//  CategoryEventViewController.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/24/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

protocol CategoryEventViewControllerDelegate{
    func categoryEventViewController(_ viewController : CategoryEventViewController, showAllSegueWithEventArray eventArray : [EventBE])
    func categoryEventViewController(_ viewController : CategoryEventViewController, didFinishLoadData arrayEvents :[EventBE])
}

enum EventsViewControllerSegue : String {
    case userEvents
    case localEvents
    case otherEvents
    
}

class CategoryEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var clvEvents: UICollectionView!
   
    var arrayEvents = [EventBE]()
    var segueIdentifierClass = EventsViewControllerSegue.localEvents
    var delegate : CategoryEventViewControllerDelegate!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if segueIdentifierClass == .localEvents{
            self.getLocalEvents()
        }else if segueIdentifierClass == .otherEvents {
            self.getOtherEvents()
        }else if segueIdentifierClass == .userEvents {
            self.getUserEvents()
        }
        
        
        // Do any additional setup after loading the view.
    }

    func getLocalEvents(){
        
        EventBC.listLocalEvents(withSuccessful: { (arrayLocalEvents, nextPage) in
            self.arrayEvents = arrayLocalEvents
            
            self.clvEvents.performBatchUpdates({
                self.clvEvents.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
            
            self.delegate.categoryEventViewController(self, didFinishLoadData: arrayLocalEvents)
            
        }) { (title, message) in
            // implement error handling
        }
    }
    
    func getOtherEvents(){
        EventBC.listOtherEvents(withSuccessful: { (arrayOtherEvents, nextPage) in
            self.arrayEvents = arrayOtherEvents
            
            self.clvEvents.performBatchUpdates({
                self.clvEvents.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
            
            self.delegate.categoryEventViewController(self, didFinishLoadData: arrayOtherEvents)
            
        }) { (title, message) in
            //implement error handling
        }
    }
    
    func getUserEvents(){
        EventBC.listUserEvents(withSuccessful: { (arrayUserEvents, nextPage) in
            self.arrayEvents = arrayUserEvents
            
            self.clvEvents.performBatchUpdates({
                self.clvEvents.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
            
            self.delegate.categoryEventViewController(self, didFinishLoadData: arrayUserEvents)
            
        }) { (title, message) in
            //implement error handling
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - DataSource, Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "EventCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EventCollectionViewCell
        cell.objEvent = self.arrayEvents[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EventDetailViewController", sender: self.arrayEvents[indexPath.row])
    }

    
    // MARK: - Navigation
     
     @IBAction func clickBtnShowAll(_ sender: Any) {
        
        self.delegate.categoryEventViewController(self, showAllSegueWithEventArray: arrayEvents)
     }
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventDetailViewController" {
            let controller = segue.destination as! EventDetailViewController
            controller.objEvent = sender as? EventBE
        }
    }
    

}
