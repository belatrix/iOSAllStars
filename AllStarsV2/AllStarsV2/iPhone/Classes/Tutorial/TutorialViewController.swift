//
//  TutorialViewController.swift
//  AllStarsV2
//
//  Created by Javier Siancas Fajardo on 10/9/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class TutorialViewController: SWFrontGenericoViewController {

    // MARK: - Properties
    
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet fileprivate weak var tutorialPageControl: UIPageControl!
    
    
    
    
    
    // MARK: - TutorialViewController's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuraciones adicionales.
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    // MARK: - @IBAction/action methods
    
    @IBAction private func skipButtonTapped(_ sender: UIButton) {
        
    }
    
}





extension TutorialViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.tutorialPageControl.currentPage = Int(pageNumber)
    }
}
