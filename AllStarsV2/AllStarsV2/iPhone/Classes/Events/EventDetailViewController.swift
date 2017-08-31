//
//  EventDetailViewController.swift
//  AllStarsV2
//
//  Created by Daniel Vasquez Fernandez on 8/28/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class EventDetailViewController: SWFrontGenericoViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var lblTitle                     : UILabel!
    @IBOutlet weak var lblDateTime                  : UILabel!
    @IBOutlet weak var imgEvent                     : UIImageView!
    @IBOutlet weak var scrollContent                   : UIScrollView!
    @IBOutlet var arrayButtonSection                : [UIButton]!
    @IBOutlet var arrayVistas                       : [UIView]!
    
    var controllerAbout                             : AboutEventViewController!
    var controllerNews                              : EventNewsViewController!
    var currentIndexSection                         : Int = 0
    var objEvent                                    : EventBE!
    
    
    func updateEventInfo(){
        if let event = self.objEvent {
            self.lblTitle?.text = "\(event.event_name)"
            self.lblDateTime?.text = "\(CDMDateManager.convertirFecha(event.event_datetime, enTextoConFormato: "yyyy'/'MM'/'dd")) - \(CDMDateManager.convertirFecha(event.event_datetime, enTextoConFormato: "HH:mm"))"
            
            CDMImageDownloaded.descargarImagen(enURL: event.event_image, paraImageView: self.imgEvent, conPlaceHolder: self.imgEvent.image, conCompletion: { (isCorrect, urlImage, image) in
                self.imgEvent.image = image
            })
            
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func clickBtnBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickBtnSection(_ sender: UIButton) {
        
        self.currentIndexSection = sender.tag
        
        for button in self.arrayButtonSection {
            let color = button == sender ? Constants.MAIN_COLOR : UIColor.lightGray
            button.setTitleColor(color, for: .normal)
        }
        
        
        
        for view in self.arrayVistas {
            view.alpha = 0
        }
        
        self.arrayVistas[sender.tag].alpha = 1
        self.scrollContent.setContentOffset(CGPoint(x: self.scrollContent.frame.size.width * CGFloat(sender.tag), y:0), animated: false)
        
        self.view.layoutIfNeeded()
    }
    
    @IBAction func clickBtnRegister(_ sender: Any) {
        //EventBC.updateUserToEvent(toEvent: self.objEvent, withAction: <#T##Bool#>, withSuccessful: <#T##Event##Event##(EventBE) -> Void#>, withAlertInformation: <#T##AlertInformation##AlertInformation##(String, String) -> Void#>)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func transitionViewSectionInto(_ scrollView : UIScrollView){
        
        if Int(scrollView.contentOffset.x) % Int(scrollView.frame.size.width) != 0 {
            
            let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            let delta = scrollView.contentOffset.x / scrollView.frame.size.width
            var alpha : CGFloat = 1.0
            
            if index < self.currentIndexSection{
                alpha = CGFloat(self.currentIndexSection) - delta
            }else{
                alpha = delta - CGFloat(self.currentIndexSection)
            }
            
            let currentView = self.arrayVistas[self.currentIndexSection]
            
            for view in self.arrayVistas{
                view.alpha = currentView == view ? (1 - alpha) : alpha
            }
            
        }else{
            self.currentIndexSection = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.transitionViewSectionInto(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.transitionViewSectionInto(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.transitionViewSectionInto(scrollView)
    }
    
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateEventInfo()
        self.clickBtnSection(self.arrayButtonSection[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AboutEventViewController" {
            self.controllerAbout            = segue.destination as! AboutEventViewController
            self.controllerAbout.objEvent   = self.objEvent!
        }else if segue.identifier == "EventNewsViewController" {
            self.controllerNews             = segue.destination as! EventNewsViewController
            self.controllerNews.objEvent    = self.objEvent!
        }
        
    }

}
