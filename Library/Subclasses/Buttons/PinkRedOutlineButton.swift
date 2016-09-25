import UIKit

class PinkRedOutlineButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8;
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.pinkRedColor().CGColor
        self.setTitleColor(UIColor.pinkRedColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override var highlighted: Bool {
        didSet {
            switch highlighted {
            case true:
                layer.borderColor = UIColor.lightGrayColor().CGColor
            case false:
                layer.borderColor = UIColor.pinkRedColor().CGColor
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
