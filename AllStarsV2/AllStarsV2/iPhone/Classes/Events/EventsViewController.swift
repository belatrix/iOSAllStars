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
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var upcomingUserEventsContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var localEventsContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var otherEventsContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var eventsCategoriesScrollViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak private var eventsCategoriesScrollView: UIScrollView!
    
    private var eventSelected: EventBE!
    var frameForEventImageViewSelected: CGRect!
    var cellSelected: EventCollectionViewCell!

    
    
    
    
    //MARK: - CategoryEventViewControllerDelegate methods

    func categoryEventViewController(_ viewController: CategoryEventViewController, didEventSelected event: EventBE, forCategory category: EventsViewControllerSegue, inCell cell: EventCollectionViewCell) {
        print("Evento seleccionado '\(event.event_name)' (\(category.rawValue))")
        self.frameForEventImageViewSelected = cell.imgEvent.convert(cell.imgEvent.frame, to: self.eventsCategoriesScrollView).offsetBy(dx: 0.0, dy: -self.eventsCategoriesScrollView.contentOffset.y)
        self.cellSelected = cell
        
        self.eventSelected = event
        self.performSegue(withIdentifier: "EventDetailViewController", sender: nil)
    }
    
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
            controller.segueIdentifierClass = (sender as! TupleSeeAllCategory).identifier
        }
        else if segue.identifier == "EventDetailViewController" {
            let controller = segue.destination as! EventDetailViewController
            controller.objEvent = self.eventSelected
        }
    }

}


