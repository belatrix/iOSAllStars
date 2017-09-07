//
//  SeeAllEventsCategoryViewController.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/28/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class SeeAllEventsCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    @IBOutlet weak var tlbEvents       : UITableView!
    @IBOutlet weak var loadingView  : CDMLoadingView!
    
    var arrayEvents     = [EventBE]()
    var nextPage        = ""
    var isDownload      = false
    var segueIdentifierClass : EventsViewControllerSegue = .localEvents
    
    lazy var refreshControl : UIRefreshControl = {
        
        var _refreshControl = UIRefreshControl()
        _refreshControl.backgroundColor = UIColor.clear
        _refreshControl.tintColor = Constants.MAIN_COLOR
        _refreshControl.addTarget(self, action:#selector(self.refreshData), for: .valueChanged)
        
        return _refreshControl
    }()
    
    @IBAction func clickBtnBack(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
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
        self.tlbEvents.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "EventDetailViewController", sender: self.arrayEvents[indexPath.row])
    }
    
    //MARK: - WebService
    
    @objc func refreshData(){
        self.listFirstPageEvents()
    }
    
    
    // MARK: -
    
    
    func listFirstPageEvents(){
        if self.arrayEvents.count == 0 {
            self.loadingView.iniciarLoading(conMensaje: "get_event_list".localized, conAnimacion: true)
        }
        
        if isDownload == true {
            return
        }
        
        if segueIdentifierClass == .localEvents {
            self.isDownload = true
            
            EventBC.listLocalEvents(withSuccessful: { (arrayEvents, nextPage) in
                
                self.endRefresh(arrayEvents, NextPage: nextPage)
                
            }, withAlertInformation: { (title, message) in
                self.isDownload = false
                self.refreshControl.endRefreshing()
                self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
                
            })
        }else if segueIdentifierClass == .otherEvents {
            self.isDownload = true
            
            EventBC.listOtherEvents(withSuccessful: { (arrayEvents, nextPage) in
                self.endRefresh(arrayEvents, NextPage: nextPage)
            }, withAlertInformation: { (title, message) in
                self.isDownload = false
                self.refreshControl.endRefreshing()
                self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
            })
        }else if segueIdentifierClass == .userEvents{
            self.isDownload = true
            
            EventBC.listUserEvents(withSuccessful: { (arrayEvents, nextPage) in
                self.endRefresh(arrayEvents, NextPage: nextPage)
            }, withAlertInformation: { (title, message) in
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
        
        self.tlbEvents.beginUpdates()
        self.tlbEvents.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
        self.tlbEvents.endUpdates()
        
        self.loadingView.detenerLoading()
    }
    
    func listAnyPageEvents(){
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tlbEvents.addSubview(self.refreshControl)
        self.tlbEvents.estimatedRowHeight = 119
        self.tlbEvents.rowHeight = UITableViewAutomaticDimension
        
        self.listFirstPageEvents()
        
        //self.listFirstPageEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listFirstPageEvents()
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
        
        if segue.identifier == "EventDetailViewController" {
            let controller = segue.destination as! EventDetailViewController
            controller.objEvent = sender as? EventBE
        }
    }
    

}
