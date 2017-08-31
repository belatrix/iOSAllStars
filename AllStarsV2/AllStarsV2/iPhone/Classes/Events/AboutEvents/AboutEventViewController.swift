//
//  AboutEventViewController.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/29/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit
import EventKit

class AboutEventViewController: UIViewController {
    
    @IBOutlet weak var lblDetailBody: UILabel!
    
    
    let eventStore : EKEventStore = EKEventStore()
    var objEvent : EventBE!
    
    func updateEventInfo(){
        self.lblDetailBody.text = self.objEvent.event_description
    }
    
    //MARK: - Actions
    @IBAction func btnAddToCalender(_ sender: Any) {
        
        
    }
    
    //MARK: - EventControllers
    
    func checkCalenderAuthorizationStatus(){
        
        let status = EKEventStore.authorizationStatus(for: .event)
        
        if status == EKAuthorizationStatus.notDetermined {
            requestAccessToCalender()
        }else if status == EKAuthorizationStatus.authorized {
            
        }
        
//        switch (status){
//
//        }
        
    }
    
    func requestAccessToCalender(){
        
    }
    
    
    //MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateEventInfo()
        // Do any additional setup after loading the view.
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
