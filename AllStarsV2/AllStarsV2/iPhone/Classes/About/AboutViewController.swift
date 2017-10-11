//
//  AboutViewController.swift
//  AllStarsV2
//
//  Created by Javier Siancas Fajardo on 10/9/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

class AboutViewController: SWFrontGenericoViewController {

    // MARK: - Properties
    
    @IBOutlet fileprivate weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var scrollViewContentTopConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var titleLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var titleLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var menuButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var headerView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet private weak var aboutScrollView: UIScrollView!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    }
    
}
