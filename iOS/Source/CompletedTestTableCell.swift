//
//  CompletedTestTableCell.swift
//  Project
//
//  Created by Ieuan Peace on 21/03/2016.
//
//

import UIKit

public class CompletedTestTableCell : FoldingCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var lapLabel: UILabel!
    
    override public func awakeFromNib() {
        foregroundView.layer.cornerRadius = 5
        foregroundView.layer.masksToBounds = true
    
        super.awakeFromNib()
    }
    
    override public func animationDuration(itemIndex:NSInteger, type:AnimationType)-> NSTimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    public func setLabels(dateString:String, levelString:String, lapString:String){
        dateLabel.text = dateString
        levelLabel.text = levelString
        lapLabel.text = lapString
    }
    
}
