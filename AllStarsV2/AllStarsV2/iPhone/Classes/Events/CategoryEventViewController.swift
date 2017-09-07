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
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var loadingView: CDMLoadingView!
    
    var arrayEvents = [EventBE]()
    var segueIdentifierClass = EventsViewControllerSegue.localEvents
    var delegate : CategoryEventViewControllerDelegate!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if self.segueIdentifierClass == .localEvents{
            self.getLocalEvents()
        }else if self.segueIdentifierClass == .otherEvents {
            self.getOtherEvents()
        }else if self.segueIdentifierClass == .userEvents {
            self.getUserEvents()
        }

    }
    
    func getLocalEvents(){
        self.loadingView.iniciarLoading(conMensaje: "No local events found".localized, conAnimacion: true)
        EventBC.listLocalEvents(withSuccessful: { (arrayLocalEvents, nextPage) in
            
            self.arrayEvents = arrayLocalEvents
            self.btnSeeAll.isHidden = self.arrayEvents.count == 0 ? true : false
            
            self.clvEvents.performBatchUpdates({
                self.clvEvents.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
            
            self.delegate.categoryEventViewController(self, didFinishLoadData: arrayLocalEvents)
            
            self.arrayEvents.count == 0 ? self.loadingView.mostrarError(conMensaje: "No local events found".localized, conOpcionReintentar: false) : self.loadingView.detenerLoading()
        }) { (title, message) in
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
        }
    }
    
    func getOtherEvents(){
        self.loadingView.iniciarLoading(conMensaje: "No other events found".localized, conAnimacion: true)
        EventBC.listOtherEvents(withSuccessful: { (arrayOtherEvents, nextPage) in
            self.arrayEvents = arrayOtherEvents
            self.btnSeeAll.isHidden = self.arrayEvents.count == 0 ? true : false
            
            self.clvEvents.performBatchUpdates({
                self.clvEvents.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
            
            self.delegate.categoryEventViewController(self, didFinishLoadData: arrayOtherEvents)
            
            self.arrayEvents.count == 0 ? self.loadingView.mostrarError(conMensaje: "No other events found".localized, conOpcionReintentar: false) : self.loadingView.detenerLoading()
        }) { (title, message) in
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
        }
    }
    
    func getUserEvents(){
        self.loadingView.iniciarLoading(conMensaje: "No events found".localized, conAnimacion: true)
        
        EventBC.listUserEvents(withSuccessful: { (arrayUserEvents, nextPage) in
            self.arrayEvents = arrayUserEvents
            self.btnSeeAll.isHidden = self.arrayEvents.count == 0 ? true : false
            
            self.delegate.categoryEventViewController(self, didFinishLoadData: arrayUserEvents)
        
            self.clvEvents.performBatchUpdates({
                self.clvEvents.reloadSections(IndexSet(integer: 0))
            }, completion: { (_) in
                self.clvEvents.layoutIfNeeded()
            })
            
            self.arrayEvents.count == 0 ? self.loadingView.mostrarError(conMensaje: "No events found".localized, conOpcionReintentar: false) : self.loadingView.detenerLoading()
            
        }) { (title, message) in
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
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
