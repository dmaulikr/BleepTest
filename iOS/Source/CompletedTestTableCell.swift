//
//  CompletedTestTableCell.swift
//  Project
//
//  Created by Ieuan Peace on 21/03/2016.
//
//

import UIKit

class CompletedTestTableCell : UITableViewCell {
    
    lazy var dateLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
        temporyLabel.translatesAutoresizingMaskIntoConstraints = false
        temporyLabel.font = UIFont(name: temporyLabel.font.fontName, size: 20)
        temporyLabel.textColor = UIColor.italyGreenColor()
        return temporyLabel
    }()
    
    lazy var levelLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
        temporyLabel.translatesAutoresizingMaskIntoConstraints = false
        temporyLabel.font = UIFont(name: temporyLabel.font.fontName, size: 20)
        temporyLabel.textColor = UIColor.customBlueColor()
        return temporyLabel
    }()
    
    lazy var lapLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
        temporyLabel.translatesAutoresizingMaskIntoConstraints = false
        temporyLabel.font = UIFont(name: temporyLabel.font.fontName, size: 20)
        temporyLabel.textColor = UIColor.customBlueColor()
        return temporyLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .whiteColor()
        addCellLabel()
    }
    
    func addCellLabel(){
        let viewsDictionary = [
            "dateLabel" : dateLabel,
            "levelLabel" : levelLabel,
            "lapLabel" : lapLabel,
            "superview" : contentView
        ]
        contentView.addSubview(dateLabel)
        contentView.addSubview(levelLabel)
        contentView.addSubview(lapLabel)
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[dateLabel]-(>=20)-|",
            options: [],
            metrics: nil,
            views: viewsDictionary
            ))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[levelLabel]-20-[lapLabel]-(>=20)-|",
            options: NSLayoutFormatOptions.AlignAllBaseline,
            metrics: nil,
            views: viewsDictionary
            ))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-10-[dateLabel]-10-[levelLabel]-10-|",
            options: [],
            metrics: nil,
            views: viewsDictionary
            ))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}