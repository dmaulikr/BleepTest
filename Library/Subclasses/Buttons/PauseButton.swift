import UIKit

class PauseButton: UIButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        if(highlighted){
            UIColor.lightGrayColor().setFill()
        } else{
            UIColor.customBlueColor().setFill()
        }
        path.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("Pause", forState: UIControlState.Normal)
        self.setTitleColor(.whiteColor(), forState: UIControlState.Normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}
