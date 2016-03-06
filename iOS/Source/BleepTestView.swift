import UIKit

class BleepTestView: UIView {
    
    let buttonSize = CGSize(width: 200, height: 50)
    let cornerRadius : CGFloat = 5
    let borderWidth : CGFloat = 1
    
    lazy var stopButton : UIButton = {
        var temporyButton : UIButton = UIButton()
        temporyButton.setTitle("Stop", forState: UIControlState.Normal)
        temporyButton.setTitleColor(.redColor(), forState: UIControlState.Normal)
        temporyButton.backgroundColor = .clearColor()
        temporyButton.layer.cornerRadius = self.cornerRadius
        temporyButton.layer.borderWidth = self.borderWidth
        temporyButton.layer.borderColor = UIColor.redColor().CGColor
        temporyButton.translatesAutoresizingMaskIntoConstraints = false
        return temporyButton
    }()
    
    lazy var startButton : UIButton = {
        var temporyButton : UIButton = UIButton()
        temporyButton.setTitle("Start", forState: UIControlState.Normal)
        temporyButton.setTitleColor(.greenColor(), forState: UIControlState.Normal)
        temporyButton.backgroundColor = .clearColor()
        temporyButton.layer.cornerRadius = self.cornerRadius
        temporyButton.layer.borderWidth = self.borderWidth
        temporyButton.layer.borderColor = UIColor.greenColor().CGColor
        temporyButton.translatesAutoresizingMaskIntoConstraints = false
        return temporyButton
    }()
    
    lazy var stageLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
     //   temporyLabel.
        return temporyLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stopButton)
        addSubview(startButton)
        creatingConstraints()
        backgroundColor = .whiteColor()
    }
    
    func creatingConstraints(){
        //make dictionary for buttons
        let viewsDictionary = [
            "stopButton":stopButton,
            "startButton":startButton,
            "superview":self
        ]
        
        //Position constraints
        let centerHorizontalyConstraint = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[stopButton]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
        )
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-75-[stopButton(50)]-(>=300)-[startButton(50)]-50-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
        )
        let stopButtonHorizontalSizeConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[stopButton(200)]",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
        )
        let startButtonHorizontalSizeConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[startButton(200)]",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
        )
        
        self.addConstraints(centerHorizontalyConstraint)
        self.addConstraints(verticalConstraints)
        self.addConstraints(stopButtonHorizontalSizeConstraints)
        self.addConstraints(startButtonHorizontalSizeConstraints)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
