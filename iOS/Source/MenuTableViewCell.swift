import UIKit

class MenuTableViewCell: UITableViewCell {
    
    lazy var cellLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
        temporyLabel.translatesAutoresizingMaskIntoConstraints = false
        temporyLabel.font = UIFont(name: temporyLabel.font.fontName, size: 20)
        temporyLabel.textColor = .whiteColor()
        return temporyLabel
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.italyGreenColor()
        addCellLabel()
    }
    func addCellLabel(){
        let viewsDictionary = [
            "cellLabel" : cellLabel,
            "superview" : contentView
        ]
        contentView.addSubview(cellLabel)
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[cellLabel]-(>=30)-|",
            options: [],
            metrics: nil,
            views: viewsDictionary
            ))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[superview]-(<=1)-[cellLabel]",
            options: NSLayoutFormatOptions.AlignAllCenterY,
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
