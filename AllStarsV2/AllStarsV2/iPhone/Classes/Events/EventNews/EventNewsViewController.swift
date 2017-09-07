//
//  EventNewsViewController.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/29/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EventNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tlbEventActivities: UITableView!
    @IBOutlet weak var loadingView: CDMLoadingView!
    
    
    var objEvent                : EventBE!
    var arrayEventActivities    = [ActivityEventBE]()
    
    lazy var refreshControl : UIRefreshControl = {
        var _refreshControl = UIRefreshControl()
        _refreshControl.backgroundColor = UIColor.clear
        _refreshControl.tintColor = Constants.MAIN_COLOR
        _refreshControl.addTarget(self, action:#selector(self.refreshData), for: .valueChanged)
        
        return _refreshControl
    }()
    
    func getActivities(){
        EventBC.listEventActivities(toEvent: self.objEvent, withSuccess: { (arrayActivities) in
            self.arrayEventActivities = arrayActivities
            self.tlbEventActivities.reloadData()
        }) { (title, message) in
            print(title)
            print(message)
        }
    }
    
    // MARK - UITableViewDelegate, UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayEventActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifer = "EventNewsTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! EventNewsTableViewCell
        cell.objEventActivity = self.arrayEventActivities[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK: - WebService
    
    @objc func refreshData(){
        self.listEventNews()
    }
    
    func listEventNews(){
        if self.arrayEventActivities.count == 0{
            self.loadingView.iniciarLoading(conMensaje: "get_event_news_list".localized, conAnimacion: true)
        }
        
        EventBC.listEventActivities(toEvent: self.objEvent, withSuccess: { (arrayActivities) in
            self.refreshControl.endRefreshing()
            self.arrayEventActivities = arrayActivities
            self.tlbEventActivities.reloadSections(IndexSet(integer: 0), with: .fade)
            
            self.loadingView.detenerLoading()
        }) { (title, message) in
            self.refreshControl.endRefreshing()
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
        }
    }
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tlbEventActivities.addSubview(self.refreshControl)
        getActivities()
        self.tlbEventActivities.estimatedRowHeight = 70.0
        
        self.listEventNews()
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
