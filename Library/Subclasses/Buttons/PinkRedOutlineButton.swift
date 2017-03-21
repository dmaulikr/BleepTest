import UIKit

class PinkRedOutlineButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(UIColor.pinkRedColor(), for: UIControlState())
        self.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
