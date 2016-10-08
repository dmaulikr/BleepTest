import UIKit

class CloseButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let closeImage = UIImage(named: "Close") as UIImage?
        self.setImage(closeImage, forState: UIControlState.Normal)
    }
    
    override var highlighted: Bool {
        didSet {
            switch highlighted {
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
