import UIKit

class LapProgressIndicator: UIView {
    var circleLayer: CAShapeLayer!
    var backgroundLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        let circlePath = UIBezierPath(
            arcCenter:
                CGPoint(
                    x: frame.size.width / 2.0,
                    y: frame.size.height / 2.0
                ),
            radius: (
                frame.size.width - 10)/2,
                startAngle: CGFloat(-Double.pi / 2),
                endAngle: CGFloat((Double.pi * 2.0) - Double.pi / 2),
                clockwise: true
        )
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.pinkRedColor().cgColor
        circleLayer.lineWidth = 5.0;
        circleLayer.strokeEnd = 0.0
        
        backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circlePath.cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.veryLightGrayColor().cgColor
        backgroundLayer.lineWidth = 5.0
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(circleLayer)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews(){
        let frame = self.layer.bounds
        circleLayer.frame = frame
        backgroundLayer.frame = frame
    }
    
    func animateCircle(_ duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        circleLayer.strokeEnd = 1.0
        circleLayer.add(animation, forKey: "animateCircle")
    }
}
