import UIKit

class SmallTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: self.font.fontName, size: 10)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.grayColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
