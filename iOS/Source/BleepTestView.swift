import UIKit

class BleepTestView: UIView {
    
    let cornerRadius : CGFloat = 5
    let borderWidth : CGFloat = 2
    
    lazy var stopButton : UIButton = {
        var temporyButton : UIButton = UIButton()
        temporyButton.setTitle("Stop", forState: UIControlState.Normal)
        temporyButton.setTitleColor(.redColor(), forState: UIControlState.Normal)
        temporyButton.addTarget(self, action: "stopButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
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
        temporyButton.setTitleColor(.italyGreenColour(), forState: UIControlState.Normal)
        temporyButton.addTarget(self, action: "startButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        temporyButton.backgroundColor = .clearColor()
        temporyButton.layer.cornerRadius = self.cornerRadius
        temporyButton.layer.borderWidth = self.borderWidth
        temporyButton.layer.borderColor = UIColor.italyGreenColour().CGColor
        temporyButton.translatesAutoresizingMaskIntoConstraints = false
        return temporyButton
    }()
    
    lazy var pauseButton : UIButton = {
        var temporyButton : UIButton = UIButton()
        temporyButton.setTitle("Pause", forState: UIControlState.Normal)
        temporyButton.setTitleColor(.blueColor(), forState: UIControlState.Normal)
        temporyButton.backgroundColor = .clearColor()
        temporyButton.layer.cornerRadius = self.cornerRadius
        temporyButton.layer.borderWidth = self.borderWidth
        temporyButton.layer.borderColor = UIColor.blueColor().CGColor
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
        
        createStartBleepTest()
        backgroundColor = .whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //This is the view when the bleep test is running
    func createRunningBleepTest(){
        let viewsDictionary = [
            "stopButton":stopButton,
            "pauseButton":pauseButton,
            "superview":self
        ]
        addSubview(stopButton)
        addSubview(pauseButton)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[stopButton]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[stopButton(50)]-20-[pauseButton(50)]-50-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[stopButton(200)]",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
            ))

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[pauseButton(200)]",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
            ))
    }
    
    //Inital view when the bleep test hasent started
    func createStartBleepTest(){
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
            "V:|-(>=20)-[startButton(50)]-120-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[startButton(200)]",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
            ))
    }
    
    func startButtonAction(sender:UIButton!){
        startButton.removeFromSuperview()
        createRunningBleepTest()
    }
    
    func stopButtonAction(sender:UIButton!){
        stopButton.removeFromSuperview()
        pauseButton.removeFromSuperview()
        createStartBleepTest()
    }

}
