import UIKit

class CloseButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let closeImage = UIImage(named: "Close") as UIImage?
        self.setImage(closeImage, for: UIControlState())
    }
    
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                setNeedsDisplay()
            case false:
                setNeedsDisplay()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
