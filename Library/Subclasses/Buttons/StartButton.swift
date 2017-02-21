import UIKit

class StartButton : UIButton {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        if(isHighlighted){
            UIColor.lightGray.setFill()
        } else{
            UIColor.customGreenColor().setFill()
        }
        path.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("Start", for: UIControlState())
        self.setTitleColor(.white, for: UIControlState())
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}
