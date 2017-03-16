import UIKit

class RedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel!.font =  UIFont(name: self.titleLabel!.font.fontName, size: 20)
        self.setTitleColor(UIColor.red, for: UIControlState())
        self.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
