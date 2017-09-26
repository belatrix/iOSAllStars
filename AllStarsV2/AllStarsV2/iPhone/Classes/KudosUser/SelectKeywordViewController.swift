//
//  SelectKeywordViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 26/09/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class SelectKeywordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var blurView                 : UIVisualEffectView!
    @IBOutlet weak var constraintTopHeader      : NSLayoutConstraint!
    @IBOutlet weak var searchKeyword            : UISearchBar!
    @IBOutlet weak var tlbKeywords              : UITableView!
    @IBOutlet weak var constraintTopTlbKeywords : NSLayoutConstraint!
    
    var arrayKeywords = [KeywordBE]()
    
    @IBAction func clickBtnAtras(_ sender: Any) {
        
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.4, animations: {
            
            self.constraintTopHeader.constant = -120
            self.constraintTopTlbKeywords.constant = UIScreen.main.bounds.size.height - 120
            self.blurView.alpha = 0
            self.tlbKeywords.alpha = 0
            self.view.layoutIfNeeded()
            
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayKeywords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "KeywordTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! KeywordTableViewCell
        cell.objKeyword = self.arrayKeywords[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.constraintTopHeader.constant = -120
        self.constraintTopTlbKeywords.constant = UIScreen.main.bounds.size.height - 120
        self.blurView.alpha = 0
        self.tlbKeywords.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        self.tlbKeywords.reloadData()
        
        UIView.animate(withDuration: 0.4) {
            self.constraintTopHeader.constant = 0
            self.constraintTopTlbKeywords.constant = 0
            self.blurView.alpha = 1
            self.tlbKeywords.alpha = 1
            self.view.layoutIfNeeded()
        }
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
