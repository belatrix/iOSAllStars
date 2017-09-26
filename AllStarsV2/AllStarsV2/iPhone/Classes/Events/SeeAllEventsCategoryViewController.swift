//
//  SeeAllEventsCategoryViewController.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/28/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class SeeAllEventsCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    // MARK: - Properties
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tlbEvents: UITableView!
    @IBOutlet weak var loadingView: CDMLoadingView!
    @IBOutlet weak var seeAllEventsTableViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewCenterXConstraint: NSLayoutConstraint!
    
    var arrayEvents     = [EventBE]()
    var nextPage        = ""
    var isDownload      = false
    var segueIdentifierClass: EventsViewControllerSegue = .localEvents
    var frameForEventImageViewSelected: CGRect!
    
    lazy var refreshControl : UIRefreshControl = {
        var _refreshControl = UIRefreshControl()
        _refreshControl.backgroundColor = UIColor.clear
        _refreshControl.tintColor = Constants.MAIN_COLOR
        _refreshControl.addTarget(self, action:#selector(self.refreshData), for: .valueChanged)
        
        return _refreshControl
    }()
    
    
    
    
    // MARK: @IBAction/action methods
    
    @IBAction func clickBtnBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    // MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EventCategoryDetailTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventCategoryDetailTableViewCell
        cell.objEventBE = self.arrayEvents[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EventCategoryDetailTableViewCell
        self.frameForEventImageViewSelected = cell.imgEvent.convert(cell.imgEvent.frame, to: self.tlbEvents)
        
        self.tlbEvents.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "EventDetailViewController", sender: self.arrayEvents[indexPath.row])
    }
    
    
    
    
    
    //MARK: - My own methods
    
    @objc func refreshData() {
        self.listFirstPageEvents()
    }

    func listFirstPageEvents() {
        if self.arrayEvents.count == 0 {
            self.loadingView.iniciarLoading(conMensaje: "get_event_list".localized, conAnimacion: true)
        }
        
        if self.isDownload == true {
            return
        }
        
        if segueIdentifierClass == .localEvents {
            self.isDownload = true
            
            EventBC.listLocalEvents(withSuccessful: { [unowned self] (arrayEvents, nextPage) in
                self.endRefresh(arrayEvents, NextPage: nextPage)
                
            }, withAlertInformation: { [unowned self] (title, message) in
                self.isDownload = false
                self.refreshControl.endRefreshing()
                self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
            })
        }
        else if segueIdentifierClass == .otherEvents {
            self.isDownload = true
            
            EventBC.listOtherEvents(withSuccessful: { [unowned self] (arrayEvents, nextPage) in
                self.endRefresh(arrayEvents, NextPage: nextPage)
                
            }, withAlertInformation: { [unowned self] (title, message) in
                self.isDownload = false
                self.refreshControl.endRefreshing()
                self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
            })
        }
        else if segueIdentifierClass == .userEvents{
            self.isDownload = true
            
            EventBC.listUserEvents(withSuccessful: { [unowned self] (arrayEvents, nextPage) in
                self.endRefresh(arrayEvents, NextPage: nextPage)
                
            }, withAlertInformation: { [unowned self] (title, message) in
                self.isDownload = false
                self.refreshControl.endRefreshing()
                self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
            })
        }
    }
    
    func endRefresh(_ arrayEvents : [EventBE], NextPage nextPage : String){
        self.refreshControl.endRefreshing()
        self.isDownload = false
        self.nextPage = nextPage
        
        self.arrayEvents = arrayEvents
        self.tlbEvents.isHidden = false
        
        self.tlbEvents.beginUpdates()
        self.tlbEvents.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
        self.tlbEvents.endUpdates()
        
        self.loadingView.detenerLoading()
    }
    
    /* func listAnyPageEvents() {
        if isDownload == true{
            return
        }
        
        self.isDownload = true
        
        EventBC.listEventToPage(self.nextPage, withSuccessful: { (arrayEvents, nextPage) in
            self.isDownload = false
            self.nextPage = nextPage
            
            var arrayIndexPath = [IndexPath]()
            
            for i in self.arrayEvents.count..<(self.arrayEvents.count + arrayEvents.count){
                arrayIndexPath.append(IndexPath(item: i, section: 0))
            }
            
            self.arrayEvents.append(contentsOf: arrayEvents)
            
            self.tlbEvents.beginUpdates()
            self.tlbEvents.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.bottom)
            self.tlbEvents.endUpdates()
            
        }, withAlertInformation: { (title, message) in
            self.isDownload = false
        })
    } */
    
    
    
    
    // MARK: - SeeAllEventsViewController's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuraciones adicionales.
        self.tlbEvents.isHidden = true
        self.tlbEvents.addSubview(self.refreshControl)
        self.tlbEvents.estimatedRowHeight = 119
        self.tlbEvents.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Configuraciones adicionales.
        self.listFirstPageEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventDetailViewController" {
            let controller = segue.destination as! EventDetailViewController
            controller.objEvent = sender as? EventBE
        }
    }
    
}
