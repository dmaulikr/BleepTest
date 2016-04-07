import UIKit

class HomeView: UIView {

    lazy var startButton : StartButtonView = {
        var temporyButton : StartButtonView = StartButtonView()
        temporyButton.setTitle("Start", forState: UIControlState.Normal)
        temporyButton.setTitleColor(.whiteColor(), forState: UIControlState.Normal)
        temporyButton.backgroundColor = .clearColor()
        temporyButton.layer.borderColor = UIColor.redColor().CGColor
        temporyButton.translatesAutoresizingMaskIntoConstraints = false
        return temporyButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createRunningBleepTest()
        backgroundColor = .whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createRunningBleepTest(){
        let viewsDictionary = [
            "startButton":startButton,
            "superview":self
        ]
        addSubview(startButton)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[startButton]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[startButton(100)]-120-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[startButton(100)]",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
            ))
    }
    
}
