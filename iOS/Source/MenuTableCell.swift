import UIKit

class MenuTableCell: UITableViewCell {
    
    lazy var cellLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
        temporyLabel.translatesAutoresizingMaskIntoConstraints = false
        temporyLabel.font = UIFont(name: temporyLabel.font.fontName, size: 20)
        temporyLabel.textColor = UIColor.customGreenColor()
        return temporyLabel
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        addCellLabel()
        accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    }
    
    func addCellLabel(){
        let viewsDictionary = [
            "cellLabel" : cellLabel,
            "superview" : contentView
        ]
        contentView.addSubview(cellLabel)
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[cellLabel]-(>=20)-|",
            options: [],
            metrics: nil,
            views: viewsDictionary
            ))
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superview]-(<=1)-[cellLabel]",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary
            ))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
