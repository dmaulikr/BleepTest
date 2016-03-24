//
//  CompletedTestTableCell.swift
//  Project
//
//  Created by Ieuan Peace on 21/03/2016.
//
//

import UIKit

public class CompletedTestTableCell : FoldingCell {
    
    override public func awakeFromNib() {
        foregroundView.layer.cornerRadius = 5
        foregroundView.layer.masksToBounds = true

        super.awakeFromNib()
    }
    
    override public func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
}