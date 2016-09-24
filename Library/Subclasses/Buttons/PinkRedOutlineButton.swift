import UIKit

class PinkRedOutlineButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8;
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.pinkRedColor().CGColor
        self.setTitleColor(UIColor.pinkRedColor(), forState: UIControlState.Normal)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
