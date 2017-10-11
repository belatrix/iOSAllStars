//
//  AboutViewController.swift
//  AllStarsV2
//
//  Created by Javier Siancas Fajardo on 10/9/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

/**
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
 */
class AboutViewController: SWFrontGenericoViewController {

    // MARK: - Properties
    
    @IBOutlet fileprivate weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var scrollViewContentTopConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var titleLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var titleLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var menuButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collaboratorsScrollViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var headerView: UIView!
    @IBOutlet fileprivate weak var menuButton: UIButton!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet private weak var aboutScrollView: UIScrollView!
    @IBOutlet private weak var collaboratorsCollectionView: UICollectionView!
    
    fileprivate var collaborators: [Collaborator]?
    fileprivate var lastContentOffset: CGPoint = CGPoint.zero
    fileprivate var maxHeightForHeaderView: CGFloat = 0.0
    fileprivate var maxLeftForTitleLabel: CGFloat = 0.0
    fileprivate var maxBottomForTitleLabel: CGFloat = 0.0
    fileprivate var maxTitleLabelFontSize: CGFloat = 0.0
    fileprivate var minHeightForHeaderView: CGFloat = 64.0
    fileprivate var minLeftForTitleLabel: CGFloat = 0.0
    fileprivate var minBottomForTitleLabel: CGFloat = 0.0
    fileprivate var minTitleLabelFontSize: CGFloat = 19.0
    
    
    
    
    
    // MARK: - AboutViewController's methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuraciones adicionales.
        self.maxHeightForHeaderView = self.headerViewHeightConstraint.constant /* El tamaño inicial de 'headerView' es lo máximo que puede aumentar. */
        self.minLeftForTitleLabel   = self.titleLabelLeftConstraint.constant /*  */
        self.maxLeftForTitleLabel   = self.menuButtonWidthConstraint.constant /*  */
        self.maxBottomForTitleLabel = self.titleLabelBottomConstraint.constant /* */
        self.maxTitleLabelFontSize  = self.titleLabel.font.pointSize
        
        self.headerView.layer.shadowOffset  = CGSize.zero
        self.headerView.layer.shadowOpacity = 0.3
        self.headerView.layer.shadowRadius  = 4.0
        
        self.headerView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        self.collaborators = [Collaborator]()
        let numberOfCollaborators = 9
        for id in 1...numberOfCollaborators { /* Cambiar '9' por el número real de colaboradores. */
            let picture         = self.pictureForCollaboratorID(id)
            let name            = self.nameForCollaboratorID(id)
            let collaborator    = Collaborator(picture: picture, name: name)
            
            self.collaborators?.append(collaborator)
        }
        
        let collectionViewLayout = self.collaboratorsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfRows = ceil(CGFloat(numberOfCollaborators) / 2.0)
        self.collaboratorsScrollViewHeightConstraint.constant = (numberOfRows * collectionViewLayout.itemSize.height) + (collectionViewLayout.minimumLineSpacing * (numberOfRows - 1.0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    // MARK: - My own methods
    
    /**
     */
    private func pictureForCollaboratorID(_ id: Int) -> UIImage? {
        switch id {
            case 1:  return #imageLiteral(resourceName: "Carina Valdez")
            case 2:  return #imageLiteral(resourceName: "Carlos Monzon")
            case 3:  return #imageLiteral(resourceName: "Diego Velasquez")
            case 4:  return #imageLiteral(resourceName: "Erick Flores")
            case 5:  return #imageLiteral(resourceName: "Fernando Puebla")
            case 6:  return #imageLiteral(resourceName: "Gladys Cuzcano")
            case 7:  return #imageLiteral(resourceName: "Karla Cerron")
            case 8:  return #imageLiteral(resourceName: "Raul Rashuaman")
            case 9:  return #imageLiteral(resourceName: "Sergio Infante")
            default: return nil
        }
    }
    
    /**
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
            default: return nil
        }
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
     */
    private func valueBetween(yRange: RangeTuple, forX x: CGFloat, between xRange: RangeTuple, functionType type: FunctionType) -> CGFloat {
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
    private func interpolate(from fromColor: UIColor, to toColor: UIColor, withProgress progress: CGFloat) -> UIColor {
        
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
        
        let yRangeForBottomTitleLabel: RangeTuple = (self.maxBottomForTitleLabel, self.minBottomForTitleLabel)
        let newTitleLabelBottom = self.valueBetween(yRange: yRangeForBottomTitleLabel, forX: scrollView.contentOffset.y, between: xRange, functionType: .decreasing)
        
        let yRangeForLeftTitleLabel: RangeTuple = (self.minLeftForTitleLabel, self.maxLeftForTitleLabel)
        let newTitleLabelLeft = self.valueBetween(yRange: yRangeForLeftTitleLabel, forX: scrollView.contentOffset.y, between: xRange, functionType: .increasing)
        
        let yRangeForTitleLabelFontSize: RangeTuple = (self.maxTitleLabelFontSize, self.minTitleLabelFontSize)
        let newTitleLabelFontSize = self.valueBetween(yRange: yRangeForTitleLabelFontSize, forX: scrollView.contentOffset.y, between: xRange, functionType: .decreasing)
        
        self.headerViewHeightConstraint.constant = (newHeaderViewHeight <= self.minHeightForHeaderView) ? self.minHeightForHeaderView : newHeaderViewHeight
        self.titleLabelBottomConstraint.constant = (newTitleLabelBottom <= self.minBottomForTitleLabel) ? self.minBottomForTitleLabel : newTitleLabelBottom
        self.titleLabelLeftConstraint.constant = (newTitleLabelLeft <= self.minLeftForTitleLabel) ? self.minLeftForTitleLabel : ((newTitleLabelLeft >= self.maxLeftForTitleLabel) ?  self.maxLeftForTitleLabel : newTitleLabelLeft)
        self.titleLabel.font = self.titleLabel.font.withSize(newTitleLabelFontSize <= self.minTitleLabelFontSize ? self.minTitleLabelFontSize : ((newTitleLabelFontSize >= self.maxTitleLabelFontSize) ?  self.maxTitleLabelFontSize : newTitleLabelFontSize))
        
        if self.headerViewHeightConstraint.constant <= self.minHeightForHeaderView { /**/ 
            self.view.insertSubview(self.headerView, belowSubview: self.menuButton)
        }
        else { /**/
            self.view.insertSubview(self.headerView, belowSubview: scrollView)
        }
        
        let finalColor = CDMColorManager.colorFromHexString("FE7633", withAlpha: 1.0)
        let initialColor = UIColor.white.withAlphaComponent(0.0)
        let progress = (scrollView.contentOffset.y / self.scrollViewContentTopConstraint.constant)
        print("\(progress)")
        self.headerView.backgroundColor = self.interpolate(from: initialColor, to: finalColor, withProgress: progress)
    }
    
}





extension AboutViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDelegateFlowLayout and UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.collaborators?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collaborator = self.collaborators![indexPath.row]
        
        let cell: AboutCollaboratorCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutCollaboratorCollectionViewCell", for: indexPath) as? AboutCollaboratorCollectionViewCell
        cell?.pictureImageView.image    = collaborator.picture
        cell?.nameLabel.text            = (collaborator.name ?? "")
        
        return cell!
    }
    
}
