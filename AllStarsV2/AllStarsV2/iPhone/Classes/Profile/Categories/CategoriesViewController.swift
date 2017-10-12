//
//  CategoriesViewController.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 2/08/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tlbCategories: UITableView!
    @IBOutlet weak var loadingView  : CDMLoadingView!
    
    var categoryCellSelected : CategoryTableViewCell!
    var objUser : UserBE!
    
    lazy var refreshControl : UIRefreshControl = {
        
        var _refreshControl = UIRefreshControl()
        _refreshControl.backgroundColor = UIColor.clear
        _refreshControl.tintColor = Constants.MAIN_COLOR
        _refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        
        return _refreshControl
    }()
    
    var arrayCategories = [CategoryBE]()
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CategoryTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CategoryTableViewCell
        cell.objCategory = self.arrayCategories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.categoryCellSelected = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell

        self.performSegue(withIdentifier: "CategoryDetailViewController", sender: self.arrayCategories[indexPath.row])
    }
    
    //MARK: - WebService
    
    @objc func refreshData(){
        
        self.listCategories()
    }
    
    func listCategories(){
        
        if self.arrayCategories.count == 0 {
            self.loadingView.iniciarLoading(conMensaje: "get_category_list", conAnimacion: true)
        }
        
        
        CategoryBC.listCategories(toUser: self.objUser, withSuccessful: { (arrayCategories) in
            
            self.refreshControl.endRefreshing()
            self.arrayCategories = arrayCategories
            self.tlbCategories.reloadSections(IndexSet(integer: 0), with: .automatic)
            
            self.loadingView.detenerLoading()
            
        }) { (title, message) in
            
            self.refreshControl.endRefreshing()
            self.loadingView.mostrarError(conMensaje: message, conOpcionReintentar: false)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tlbCategories.addSubview(self.refreshControl)
        self.tlbCategories.estimatedRowHeight = 30
        self.tlbCategories.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.listCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CategoryDetailViewController" {
            
            let controller = segue.destination as! CategoryDetailViewController
            controller.objCategory = sender as! CategoryBE
            controller.objUser = self.objUser
        }
    }
    

}
