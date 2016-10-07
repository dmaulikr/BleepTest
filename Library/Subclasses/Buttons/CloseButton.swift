import UIKit

class CloseButton: UIButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        if(highlighted){
            UIColor.lightGrayColor().setFill()
        } else{
            UIColor.veryLightGrayColor().setFill()
        }
        path.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("X", forState:UIControlState.Normal)
        self.setTitleColor(.whiteColor(), forState: UIControlState.Normal)
        self.titleLabel?.font = UIFont(name: (self.titleLabel?.font.fontName)!, size: 15)
        self.translatesAutoresizingMaskIntoConstraints = false
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
