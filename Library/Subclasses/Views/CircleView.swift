import UIKit

class CircleView: UIView {
    var circleLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2.0,
                y: frame.size.height / 2.0
            ),
            radius: (
                frame.size.width - 10)/2,
            startAngle: 0.0,
            endAngle: CGFloat(Double.pi * 2.0),
            clockwise: true
        )
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.customBlueColor().cgColor
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
