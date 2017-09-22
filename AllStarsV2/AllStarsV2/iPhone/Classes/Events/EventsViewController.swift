//
//  EventsViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 1/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

typealias TupleSeeAllCategory = (arrayEvents : [EventBE], identifier : EventsViewControllerSegue)

class EventsViewController: SWFrontGenericoViewController, CategoryEventViewControllerDelegate {
    
    @IBOutlet weak var upcomingUserEventsConstraint: NSLayoutConstraint!
    @IBOutlet weak var localEventsConstraint: NSLayoutConstraint!
    @IBOutlet weak var otherEventsConstraint: NSLayoutConstraint!

    
    
    
    
    //MARK: - CategoryEventViewControllerDelegate methods

    func categoryEventViewController(_ viewController: CategoryEventViewController, didFinishLoadData arrayEvents: [EventBE]) { }
    
    func categoryEventViewController(_ viewController: CategoryEventViewController, showAllSegueWithEventArray eventArray: [EventBE]) {
        let tupleDataSegue : TupleSeeAllCategory = (eventArray, viewController.segueIdentifierClass)
        let identifier = "SeeAllEventsCategoryViewController"
        self.performSegue(withIdentifier: identifier, sender: tupleDataSegue)
    }
    
    
    
    
    
    //MARK: - EventsViewController's methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == EventsViewControllerSegue.localEvents.rawValue || segue.identifier == EventsViewControllerSegue.otherEvents.rawValue || segue.identifier == EventsViewControllerSegue.userEvents.rawValue {
            
            let controller = segue.destination as! CategoryEventViewController
            controller.delegate = self
            controller.segueIdentifierClass = EventsViewControllerSegue(rawValue: segue.identifier!)!
            
        }
        else if segue.identifier == "SeeAllEventsCategoryViewController" {
            
            let controller = segue.destination as! SeeAllEventsCategoryViewController
            controller.arrayEvents = (sender as! TupleSeeAllCategory).arrayEvents
            controller.segueIdentifierClass = (sender as! TupleSeeAllCategory).identifier
        }
    }

}


