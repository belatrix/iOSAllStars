//
//  RankingViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 17/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class RankingViewController: SWFrontGenericoViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tlbUsers                 : UITableView!
    @IBOutlet weak var constraintSectionSelected: NSLayoutConstraint!
    @IBOutlet var arrayButtonsSection           : [UIButton]!
    
    var currenteIndexSection                    : Int = 0
    
    var arrayCurrentMonth                       = [UserBE]() {
        didSet{
            if self.currenteIndexSection == 0{
                self.arrayUsers = self.arrayCurrentMonth
            }
        }
    }
    
    var arraLastMonth                           = [UserBE]() {
        didSet{
            if self.currenteIndexSection == 1{
                self.arrayUsers = self.arraLastMonth
            }
        }
    }
    
    var arrayAllTime                            = [UserBE]() {
        didSet{
            if self.currenteIndexSection == 2{
                self.arrayUsers = self.arrayAllTime
            }
        }
    }
    
    
    var arrayUsers                              = [UserBE]() {
        didSet{
            self.tlbUsers.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayUsers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "UserRankingTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserRankingTableViewCell
        cell.objContact = self.arrayUsers[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "UserProfileViewController", sender: self.arrayUsers[indexPath.row])
    }
    
    
    //MARK: - Selecction kind
    
    @IBAction func clicBtnSection(_ sender: UIButton) {
        
        self.currenteIndexSection = sender.tag
        self.listEmployeeByTagSection(self.currenteIndexSection)
        
        if self.currenteIndexSection == 0 {
            self.arrayUsers = self.arrayCurrentMonth
        }else if self.currenteIndexSection == 1 {
            self.arrayUsers = self.arraLastMonth
        }else if self.currenteIndexSection == 2 {
            self.arrayUsers = self.arrayAllTime
        }
        
        UIView.animate(withDuration: 0.55, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            for button in self.arrayButtonsSection{
                let color = button == sender ? Constants.MAIN_COLOR : UIColor.lightGray
                button.setTitleColor(color, for: .normal)
            }
            
            self.constraintSectionSelected.constant =  sender.center.x - UIScreen.main.bounds.size.width / 2
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    func getKindByTag(_ tag : Int) -> TypeKind {
        
        if tag == 0 {
            return .currentMonthScore
        }else if tag == 1 {
            return .lastMonthScore
        }else{
            return .totalScore
        }
    }
    
    func listEmployeeByTagSection(_ tag : Int) {
        
        let kind = self.getKindByTag(tag)
        
        RankingBC.listEmployeeByKind(kind.rawValue, withSuccessful: { (arrayUsers) in
        
            if kind == .currentMonthScore {
                self.arrayCurrentMonth = arrayUsers
            }else if kind == .lastMonthScore {
                self.arraLastMonth = arrayUsers
            }else if kind == .totalScore {
                self.arrayAllTime = arrayUsers
            }
            
        }) { (title, message) in
            
        }
    }
    
    func selectSectionWithoutAnimation(_ sender: UIButton){
        
        self.currenteIndexSection = sender.tag
        
        for button in self.arrayButtonsSection{
            let color = button == sender ? Constants.MAIN_COLOR : UIColor.lightGray
            button.setTitleColor(color, for: .normal)
        }
        
        if sender.tag == 0 {
            self.arrayUsers = self.arrayCurrentMonth
        }else if sender.tag == 1 {
            self.arrayUsers = self.arraLastMonth
        }else if sender.tag == 2 {
            self.arrayUsers = self.arrayAllTime
        }
        
        self.constraintSectionSelected.constant =  sender.center.x - UIScreen.main.bounds.size.width / 2
        
        self.view.layoutIfNeeded()
    }

    
    //MARK: - ViewController
    
    override func loadView() {
        
        super.loadView()
        self.selectSectionWithoutAnimation(self.arrayButtonsSection[0])
        
        for btn in self.arrayButtonsSection{
            self.listEmployeeByTagSection(btn.tag)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
        if segue.identifier == "UserProfileViewController" {
            let controller = segue.destination as! UserProfileViewController
            controller.objUser = sender as? UserBE
        }
    }
    

}
