//
//  TutorialViewController.swift
//  AllStarsV2
//
//  Created by Javier Siancas Fajardo on 10/9/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

/**
 Clase que maneja las imágenes del tutorial de la aplicación.
 */
class TutorialViewController: SWFrontGenericoViewController {

    // MARK: - Properties
    
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var menuButton: UIButton!
    @IBOutlet private weak var tutorial1ImageView: UIImageView!
    @IBOutlet private weak var tutorial2ImageView: UIImageView!
    @IBOutlet private weak var tutorial3ImageView: UIImageView!
    @IBOutlet fileprivate weak var tutorialPageControl: UIPageControl!
    
    
    
    
    
    // MARK: - TutorialViewController's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuraciones adicionales.
        UIApplication.shared.statusBarStyle = .lightContent
        
        if let _ = self.revealViewController() { /* La instancia de TutorialViewController pertenece a la de SWRevealViewController. */
            self.skipButton.alpha = 0.0
            self.menuButton.alpha = 1.0
        }
        else { /* El tutorial se muestra al inicio de la aplicación, después de iniciar sesión. */
            self.skipButton.setTitle("skip".localized,
                                     for: .normal)
            
            self.skipButton.alpha = 1.0
            self.menuButton.alpha = 0.0
        }
        
        // Mostrar las imágenes del tutorial solo si el idioma es diferente al español.
        if let languageCode = Locale.current.languageCode, languageCode != "es" { /* El lenguage es diferente al español. En el "storyboard", las imágenes están en ese idioma. */
            
            /*
             It's important to make the difference between the application language and the device locale language:
             - "Locale.current.languageCode" will return the device language.
             - "Locale.preferredLanguages[0]" will return the application language.
             */
            
            self.tutorial1ImageView.image = #imageLiteral(resourceName: "en-Tutorial 1")
            self.tutorial2ImageView.image = #imageLiteral(resourceName: "en-tutorial 2")
            self.tutorial3ImageView.image = #imageLiteral(resourceName: "en-tutorial 3")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    // MARK: - @IBAction/action methods
    
    /**
     Método para ocultar o finalizar el tutorial.
     - Parameter sender: El UIButton que ejecuta este método.
     */
    @IBAction private func skipButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}





extension TutorialViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.tutorialPageControl.currentPage = Int(pageNumber)
        
        if self.tutorialPageControl.currentPage == 2 {
            self.skipButton.setTitle("go".localized,
                                     for: .normal)
        }
    }
}
