import UIKit

class BlueButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel!.font =  UIFont(name: self.titleLabel!.font.fontName, size: 40)
        self.setTitleColor(UIColor.customBlueColor(), for: UIControlState())
        self.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
