import UIKit

class LargeContentLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: self.font.fontName, size: 40)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.blackColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}