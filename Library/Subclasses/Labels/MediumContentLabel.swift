import UIKit

class MediumContentLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: self.font.fontName, size: 23)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.italyBrownColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}