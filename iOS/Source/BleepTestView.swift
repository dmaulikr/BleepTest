import UIKit

class BleepTestView: UIView {
    lazy var stopButton: UIButton = {
        var temporyButton : UIButton = UIButton()
        temporyButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        temporyButton.center = CGPoint(x: 160, y: 100)
        temporyButton.setTitle("Stop", forState: UIControlState.Normal)
        temporyButton.setTitleColor(.redColor(), forState: UIControlState.Normal)
        temporyButton.backgroundColor = .clearColor()
        temporyButton.layer.cornerRadius = 5
        temporyButton.layer.borderWidth = 1
        temporyButton.layer.borderColor = UIColor.redColor().CGColor
        return temporyButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stopButton)
        backgroundColor = .whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
