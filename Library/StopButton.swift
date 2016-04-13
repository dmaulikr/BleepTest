import UIKit

class StopButton: UIButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.redColor().setFill()
        path.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("Stop", forState: UIControlState.Normal)
        self.setTitleColor(.whiteColor(), forState: UIControlState.Normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
