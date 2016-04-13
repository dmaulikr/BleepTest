import UIKit

class CircleView: UIView {
    var circleLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2.0,
                y: frame.size.height / 2.0
            ),
            radius: (
                frame.size.width - 10)/2,
            startAngle: 0.0,
            endAngle: CGFloat(M_PI * 2.0),
            clockwise: true
        )
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.customBlueColor().CGColor
        layer.addSublayer(circleLayer)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews(){
        let frame = self.layer.bounds
        circleLayer.frame = frame
    }
}
