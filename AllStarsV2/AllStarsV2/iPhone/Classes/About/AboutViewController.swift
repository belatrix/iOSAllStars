//
//  AboutViewController.swift
//  AllStarsV2
//
//  Created by Javier Siancas Fajardo on 10/9/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit
import MessageUI

/**
 Clase que representa a un colaborador de la aplicación.
 */
class Collaborator {
    
    // MARK: - Properties
    
    internal var picture: UIImage?
    internal var name: String?
    
    
    // MARK: - Collaborator's methods
    init(picture: UIImage?, name: String?) {
        self.picture    = picture
        self.name       = name
    }
    
}

/**
 Clase que maneja la información relevante de la aplicación "Belatrix Connect".
 */
class AboutViewController: SWFrontGenericoViewController {

    // MARK: - Properties
    
    @IBOutlet fileprivate weak var headerViewHeightConstraint           : NSLayoutConstraint!
    @IBOutlet fileprivate weak var scrollViewContentTopConstraint       : NSLayoutConstraint!
    @IBOutlet fileprivate weak var titleLabelLeftConstraint             : NSLayoutConstraint!
    @IBOutlet fileprivate weak var titleLabelBottomConstraint           : NSLayoutConstraint!
    @IBOutlet private weak var menuButtonWidthConstraint                : NSLayoutConstraint!
    @IBOutlet private weak var collaboratorsScrollViewHeightConstraint  : NSLayoutConstraint!
    @IBOutlet fileprivate weak var headerView                           : UIView!
    @IBOutlet fileprivate weak var menuButton                           : UIButton!
    @IBOutlet fileprivate weak var titleLabel                           : UILabel!
    @IBOutlet private weak var collaboratorsCollectionView              : UICollectionView!
    @IBOutlet private weak var whatLabel                                : UILabel!
    @IBOutlet private weak var whyLabel                                 : UILabel!
    @IBOutlet private weak var whoLabel                                 : UILabel!
    @IBOutlet private weak var licenseLabel                             : UILabel!
    @IBOutlet private weak var emailButton                              : UIButton!
    
    fileprivate var collaborators           : [Collaborator]?
    fileprivate var maxHeightForHeaderView  : CGFloat = 0.0
    fileprivate var maxLeftForTitleLabel    : CGFloat = 0.0
    fileprivate var maxBottomForTitleLabel  : CGFloat = 0.0
    fileprivate var maxTitleLabelFontSize   : CGFloat = 0.0
    fileprivate var minHeightForHeaderView  : CGFloat = 64.0
    fileprivate var minLeftForTitleLabel    : CGFloat = 0.0
    fileprivate var minBottomForTitleLabel  : CGFloat = 0.0
    fileprivate var minTitleLabelFontSize   : CGFloat = 19.0
    
    
    
    
    
    // MARK: - AboutViewController's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuraciones adicionales.
        self.headerViewHeightConstraint.constant = (0.3178 * UIScreen.main.bounds.height)
        self.maxHeightForHeaderView = self.headerViewHeightConstraint.constant /* La altura máxima del `headerView`. */
        self.minLeftForTitleLabel   = self.titleLabelLeftConstraint.constant /* El espacio mínimo a la izquierda del `titleLabel`. */
        self.maxLeftForTitleLabel   = self.menuButtonWidthConstraint.constant /* El espacio máximo a la derecha del `titleLabel`. */
        self.maxBottomForTitleLabel = self.titleLabelBottomConstraint.constant /* La separación máxima de abajo del `titleLabel`. */
        self.maxTitleLabelFontSize  = self.titleLabel.font.pointSize /* El tamaño máximo de la fuente del `titleLabel`. */
        self.scrollViewContentTopConstraint.constant = (self.headerViewHeightConstraint.constant - 64.0 - 20.0)
        
        self.headerView.layer.shadowOffset  = CGSize.zero
        self.headerView.layer.shadowOpacity = 0.3
        self.headerView.layer.shadowRadius  = 4.0
        self.headerView.backgroundColor     = UIColor.white.withAlphaComponent(0.0)
        
        let attributes: [NSAttributedStringKey: Any] = [
                    NSAttributedStringKey.font:             UIFont(name: "HelveticaNeue", size: 15.0)!,
                    NSAttributedStringKey.foregroundColor : CDMColorManager.colorFromHexString("007AFF", withAlpha: 1.0),
                    NSAttributedStringKey.underlineStyle :  NSUnderlineStyle.styleSingle.rawValue
                ]
        let emailAttributedString = NSAttributedString(string: "mobilelab@belatrixsf.com", attributes: attributes)
        self.emailButton.setAttributedTitle(emailAttributedString, for: .normal)
        
        // Obtener colaboradores.
        self.collaborators = [Collaborator]()
        let numberOfCollaborators = 12
        for id in 1...numberOfCollaborators { /* Cambiar '11' por el número real de colaboradores. */
            let picture = self.pictureForCollaboratorID(id)
            let name = self.nameForCollaboratorID(id)
            let collaborator = Collaborator(picture: picture, name: name)
            self.collaborators?.append(collaborator)
        }
        
        let collectionViewLayout = self.collaboratorsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfRows = ceil(CGFloat(numberOfCollaborators) / 2.0)
        self.collaboratorsScrollViewHeightConstraint.constant = (numberOfRows * collectionViewLayout.itemSize.height) + (collectionViewLayout.minimumLineSpacing * (numberOfRows - 1.0)) /* - 1.0, porque la última fila no tiene espaciado. */
        
        // Mostrar los textos.
        self.whatLabel.text     = "what_text".localized
        self.whyLabel.text      = "why_text".localized
        self.whoLabel.text      = "who_text".localized
        self.licenseLabel.text  = "license_text".localized
        
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    // MARK: - My own methods
    
    /**
     Método para obtener la foto de perfil de un colaborador por su identificador.
     - Parameter id: El identificador del colaborador.
     - Returns: La foto de perfil del colaborador o `nil` si no tiene.
     */
    private func pictureForCollaboratorID(_ id: Int) -> UIImage? {
        switch id {
            case 1:  return #imageLiteral(resourceName: "Carina Valdez")
            case 2:  return #imageLiteral(resourceName: "Carlos Monzon")
            case 3:  return #imageLiteral(resourceName: "Diego Velasquez")
            case 4:  return #imageLiteral(resourceName: "Erik Flores")
            case 5:  return #imageLiteral(resourceName: "Fernando Puebla")
            case 6:  return #imageLiteral(resourceName: "Gladys Cuzcano")
            case 7:  return #imageLiteral(resourceName: "Karla Cerron")
            case 8:  return #imageLiteral(resourceName: "Raul Rashuaman")
            case 9:  return #imageLiteral(resourceName: "Sergio Infante")
            case 10: return #imageLiteral(resourceName: "Kenyi Rodriguez")
            case 11: return #imageLiteral(resourceName: "Javier Siancas")
            case 12: return #imageLiteral(resourceName: "Yanina Giraldo")
            default: return nil
        }
    }
    
    /**
     Método para obtener los nombres y apellidos del colaborador por su identificador.
     - Parameter id: El identificador del colaborador.
     - Returns: Los nombres y apellidos del colaborador o `nil` si no tiene.
     */
    private func nameForCollaboratorID(_ id: Int) -> String? {
        switch id {
            case 1:  return "Carina Valdez"
            case 2:  return "Carlos Monzón"
            case 3:  return "Diego Velásquez"
            case 4:  return "Erik Flores"
            case 5:  return "Fernando Puebla"
            case 6:  return "Gladys Cuzcano"
            case 7:  return "Karla Cerrón"
            case 8:  return "Raul Rashuaman"
            case 9:  return "Sergio Infante"
            case 10 : return "Kenyi Rodriguez"
            case 11 : return "Javier Siancas"
            case 12 : return "Yanina Giraldo"
            default: return nil
        }
    }
    
    
    
    
    
    // MARK: - @IBAction/action methods
    
    /**
     Método para enviar un correo electrónico a "mobilelab@belatrixsf.com".
     - Parameter sender: El `UIButton` que ejecuta este método.
     */
    @IBAction private func sendEmailButtonTapped(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() == false { /* See if the current device is configured to send email... */
            CDMUserAlerts.showSimpleAlert(title: "generic_title_problem".localized,
                                          withMessage: "no_email_setup".localized,
                                          withAcceptButton: "accept".localized,
                                          withController: self,
                                          withCompletion: nil)
            
            return
        }
        
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients(["mobilelab@belatrixsf.com"])
        self.present(mailComposeViewController,
                     animated: true,
                     completion: nil)
    }
    
}





extension AboutViewController: UIScrollViewDelegate {
    
    // MARK: - Definitions
    
    typealias RangeTuple = (value1: CGFloat, value2: CGFloat)
    enum FunctionType: Int {
        case increasing
        case decreasing
    }
    
    
    
    
    
    // MARK: - My own methods
    
    /**
     Método para obtener un valor en función de otro.
     - Parameters:
         - yRange: El rango de valores mínimo y máximo donde se encuentra el nuevo valor.
         - x: El valor que permite obtener el nuevo valor.
         - xRange: El rango de valores mínimo y máximo donde se encuentra el valor de `x`.
         - type: El tipo de función si la pendiente es negativa (`.decreasing`) o positiva (`.increasing`).
     - Returns:
     */
    private func valueBetween(yRange: RangeTuple,
                              forX x: CGFloat,
                              between xRange: RangeTuple,
                              functionType type: FunctionType) -> CGFloat {
        
        let exp1 = (type == .decreasing) ? (yRange.value1 * (xRange.value2 - x)) : (yRange.value2 * (x - xRange.value1))
        let exp2 = (type == .decreasing) ? (yRange.value2 * (xRange.value1 - x)) : (yRange.value1 * (x - xRange.value2))
        let exp3 = (xRange.value2 - xRange.value1)
        
        return ((exp1 - exp2) / exp3)
    }
    
    /**
     Método para obtener una instancia de `UIColor` interpolando entre otros dos `UIColor`.
     - Parameters:
         - fromColor: El `UIColor` desde el cual se va a interpolar.
         - toColor: El `UIColor` hacia el cual se va a interpolar.
         - progress: El progreso de la interpolación. El valor debe estar entre 0.0 y 1.0, pero, si no se envía en este rango, este método se encarga de establecer el límite.
     - Returns: The interpolated `UIColor` for the given progress point
     */
    private func interpolate(from fromColor: UIColor,
                             to toColor: UIColor,
                             withProgress progress: CGFloat) -> UIColor {
        
        /**
         Función para obtener los componentes RGB (y alpha) de un color.
         - Parameter color: El color para obtener sus componentes.
         - Returns: Tupla con los componentes RGB (y alpha) de un color.
         */
        func components(for color: UIColor) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
            let components = color.cgColor.components!
            
            switch components.count == 2 {
                case true : return (r: components[0], g: components[0], b: components[0], a: components[1])
                case false: return (r: components[0], g: components[1], b: components[2], a: components[3])
            }
        }
        
        var _progress = min(progress, 1.0)
        _progress = max(_progress, 0.0)
        
        let fromComponents = components(for: fromColor)
        let toComponents = components(for: toColor)
        
        let r = (1 - _progress) * fromComponents.r + _progress * toComponents.r
        let g = (1 - _progress) * fromComponents.g + _progress * toComponents.g
        let b = (1 - _progress) * fromComponents.b + _progress * toComponents.b
        let a = (1 - _progress) * fromComponents.a + _progress * toComponents.a
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    
    
    
    // MARK: - UIScrollViewDelegate methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xRange: RangeTuple = (0.0, self.scrollViewContentTopConstraint.constant)
        
        let yRangeForHeaderView: RangeTuple = (self.maxHeightForHeaderView, self.minHeightForHeaderView)
        let newHeaderViewHeight = self.valueBetween(yRange: yRangeForHeaderView, forX: scrollView.contentOffset.y, between: xRange, functionType: .decreasing)
        self.headerViewHeightConstraint.constant = (newHeaderViewHeight <= self.minHeightForHeaderView) ? self.minHeightForHeaderView : newHeaderViewHeight
        
        if self.headerViewHeightConstraint.constant <= self.minHeightForHeaderView { /* Se muestra el `headerView` encima del `UIScrollView` sin ocultar el botón `menuButton`. */
            self.view.insertSubview(self.headerView, belowSubview: self.menuButton)
        }
        else { /* Se muestra el `headerView` por debajo del `UIScrollView`. */
            self.view.insertSubview(self.headerView, belowSubview: scrollView)
        }
        
        let yRangeForBottomTitleLabel: RangeTuple = (self.maxBottomForTitleLabel, self.minBottomForTitleLabel)
        let newTitleLabelBottom = self.valueBetween(yRange: yRangeForBottomTitleLabel, forX: scrollView.contentOffset.y, between: xRange, functionType: .decreasing)
        self.titleLabelBottomConstraint.constant = (newTitleLabelBottom <= self.minBottomForTitleLabel) ? self.minBottomForTitleLabel : newTitleLabelBottom
        
        let yRangeForLeftTitleLabel: RangeTuple = (self.minLeftForTitleLabel, self.maxLeftForTitleLabel)
        let newTitleLabelLeft = self.valueBetween(yRange: yRangeForLeftTitleLabel, forX: scrollView.contentOffset.y, between: xRange, functionType: .increasing)
        self.titleLabelLeftConstraint.constant = (newTitleLabelLeft <= self.minLeftForTitleLabel) ? self.minLeftForTitleLabel : ((newTitleLabelLeft >= self.maxLeftForTitleLabel) ?  self.maxLeftForTitleLabel : newTitleLabelLeft)
        
        let yRangeForTitleLabelFontSize: RangeTuple = (self.maxTitleLabelFontSize, self.minTitleLabelFontSize)
        let newTitleLabelFontSize = self.valueBetween(yRange: yRangeForTitleLabelFontSize, forX: scrollView.contentOffset.y, between: xRange, functionType: .decreasing)
        self.titleLabel.font = self.titleLabel.font.withSize(newTitleLabelFontSize <= self.minTitleLabelFontSize ? self.minTitleLabelFontSize : ((newTitleLabelFontSize >= self.maxTitleLabelFontSize) ?  self.maxTitleLabelFontSize : newTitleLabelFontSize))
        
        let finalColor = CDMColorManager.colorFromHexString("FE7633", withAlpha: 1.0)
        let initialColor = UIColor.white.withAlphaComponent(0.0)
        let progress = (scrollView.contentOffset.y / self.scrollViewContentTopConstraint.constant)
        self.headerView.backgroundColor = self.interpolate(from: initialColor, to: finalColor, withProgress: progress)
    }
    
}





extension AboutViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDelegateFlowLayout and UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return (self.collaborators?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collaborator = self.collaborators![indexPath.row]
        
        let cell: AboutCollaboratorCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutCollaboratorCollectionViewCell", for: indexPath) as? AboutCollaboratorCollectionViewCell
        cell?.pictureImageView.image    = collaborator.picture
        cell?.nameLabel.text            = (collaborator.name ?? "")
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth   = (collectionView.frame.size.width / 2.0)
        let itemHeight  = (collectionViewLayout as! UICollectionViewFlowLayout).itemSize.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}





extension AboutViewController: MFMailComposeViewControllerDelegate {
    
    // MARK: - MFMailComposeViewController's methods
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) { /* When the user taps the buttons to send the email or cancel the interface, the mail compose view controller calls this method of its delegate. */
        
        controller.dismiss(animated: true, completion: nil)
    }
    
}
