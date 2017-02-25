import UIKit

class PinkRedOutlineButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8;
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.pinkRedColor().cgColor
        self.setTitleColor(UIColor.pinkRedColor(), for: UIControlState())
        self.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        self.backgroundColor = UIColor.clear
    }
    
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                layer.borderColor = UIColor.lightGray.cgColor
            case false:
                layer.borderColor = UIColor.pinkRedColor().cgColor
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
