//
//  SelectKeywordViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 26/09/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

protocol SelectKeywordViewControllerDelegate {
    func selectKeywordViewController(_ controller: SelectKeywordViewController, selectKeyword keyword: KeywordBE)
    func selectKeywordViewController(_ controller: SelectKeywordViewController, addKeyword keyword: KeywordBE)
}

class SelectKeywordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var blurView                 : UIVisualEffectView!
    @IBOutlet weak var constraintTopHeader      : NSLayoutConstraint!
    @IBOutlet weak var searchKeyword            : UISearchBar!
    @IBOutlet weak var tlbKeywords              : UITableView!
    @IBOutlet weak var constraintTopTlbKeywords : NSLayoutConstraint!
    
    
    var delegate                                : SelectKeywordViewControllerDelegate!
    var arrayKeywords                           = [KeywordBE]()
    var objKeywordSelected                      : KeywordBE?
    var arrayKeywordsTable                      = [Any]()
    
    @IBAction func clickBtnAtras(_ sender: Any?) {
        
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
    
    
    //MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count == 0 {
            self.arrayKeywordsTable = self.arrayKeywords
        }else{

            self.arrayKeywordsTable = self.arrayKeywords.filter({return $0.keyword_name.contains(searchText)})
            if arrayKeywordsTable.count == 0{
                self.arrayKeywordsTable.append(searchText)
            }
        }
        
        self.tlbKeywords.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    
    //MARK: - UITableViewDataSource, UISearchBarDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayKeywordsTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.arrayKeywordsTable[indexPath.row] is KeywordBE{
            return self.createKeyboardTableView(tableView, cellForRowAt: indexPath)
        }else{
            return self.createAddKeyboardtableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    func createKeyboardTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "KeywordTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! KeywordTableViewCell
        cell.objKeyword = self.arrayKeywordsTable[indexPath.row] as! KeywordBE
        
        if self.arrayKeywords[indexPath.row] == self.objKeywordSelected {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            cell.selectCell(true)
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
            cell.selectCell(false)
        }
        
        return cell
    }
    
    func createAddKeyboardtableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "AddKeywordTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AddKeywordTableViewCell
        cell.objTitleTag = self.arrayKeywordsTable[indexPath.row] as! String
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell is KeywordTableViewCell {
            
            (cell as! KeywordTableViewCell).selectCell(true)
            self.objKeywordSelected = self.arrayKeywords[indexPath.row]
            self.delegate.selectKeywordViewController(self, selectKeyword: self.arrayKeywords[indexPath.row])
            
        }else{
            
            let obj = KeywordBE()
            obj.keyword_name = self.arrayKeywordsTable[indexPath.row] as! String
            
            self.delegate.selectKeywordViewController(self, addKeyword: obj)
            self.delegate.selectKeywordViewController(self, selectKeyword: obj)
            
            self.clickBtnAtras(nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell is KeywordTableViewCell{
            (cell as! KeywordTableViewCell).selectCell(false)
        }
    }
    
    //MARK: -
    
    func getKeywordByKeywordReference(_ keyword: KeywordBE?) -> KeywordBE? {
        
        if keyword == nil {
            return nil
        }
        
        let arrayResult = self.arrayKeywords.filter({$0.keyword_pk == keyword!.keyword_pk})
        return arrayResult.count == 0 ? nil : arrayResult[0]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.objKeywordSelected = self.getKeywordByKeywordReference(self.objKeywordSelected)
        
        self.tlbKeywords.estimatedRowHeight = 55
        self.tlbKeywords.rowHeight = UITableViewAutomaticDimension
        
        self.constraintTopHeader.constant = -120
        self.constraintTopTlbKeywords.constant = UIScreen.main.bounds.size.height - 120
        self.blurView.alpha = 0
        self.tlbKeywords.alpha = 0
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        self.tlbKeywords.reloadData()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            
            self.constraintTopHeader.constant = 0
            self.constraintTopTlbKeywords.constant = 0
            self.blurView.alpha = 1
            self.tlbKeywords.alpha = 1
            self.view.layoutIfNeeded()
            
        }, completion: nil)
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
