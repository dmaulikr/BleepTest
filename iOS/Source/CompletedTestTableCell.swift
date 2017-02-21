//
//  CompletedTestTableCell.swift
//  Project
//
//  Created by Ieuan Peace on 21/03/2016.
//
//

import UIKit

open class CompletedTestTableCell : FoldingCell {
    
    override open func awakeFromNib() {
        foregroundView.layer.cornerRadius = 5
        foregroundView.layer.masksToBounds = true

        super.awakeFromNib()
    }
    
    override open func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
}
