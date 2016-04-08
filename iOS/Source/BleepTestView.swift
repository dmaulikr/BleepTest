import UIKit

class BleepTestView: UIView {
    
    let cornerRadius : CGFloat = 5
    let borderWidth : CGFloat = 2
    
    lazy var stopButton : StopButton = {
        var temporyButton : StopButton = StopButton()
        temporyButton.setTitle("Stop", forState: UIControlState.Normal)
        temporyButton.setTitleColor(.whiteColor(), forState: UIControlState.Normal)
        temporyButton.addTarget(self, action: #selector(stopButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        temporyButton.translatesAutoresizingMaskIntoConstraints = false
        return temporyButton
    }()

    lazy var pauseButton : PauseButton = {
        var temporyButton : PauseButton = PauseButton()
        temporyButton.setTitle("Pause", forState: UIControlState.Normal)
        temporyButton.setTitleColor(.whiteColor(), forState: UIControlState.Normal)
        temporyButton.addTarget(self, action: #selector(pauseButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        temporyButton.translatesAutoresizingMaskIntoConstraints = false
        return temporyButton
    }()

    lazy var levelLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
        temporyLabel.text = "Level: 0"
        temporyLabel.font = UIFont(name: temporyLabel.font.fontName, size: 30)
        temporyLabel.translatesAutoresizingMaskIntoConstraints = false
        temporyLabel.textColor = UIColor.italyBrownColor()
        return temporyLabel
    }()
    
    lazy var lapLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
        temporyLabel.text = "Lap: 0"
        temporyLabel.font = UIFont(name: temporyLabel.font.fontName, size: 30)
        temporyLabel.translatesAutoresizingMaskIntoConstraints = false
        temporyLabel.textColor = UIColor.italyBrownColor()
        return temporyLabel
    }()
    
    lazy var distanceLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
        temporyLabel.text = "Total distance: 0m"
        temporyLabel.font = UIFont(name: temporyLabel.font.fontName, size: 23)
        temporyLabel.translatesAutoresizingMaskIntoConstraints = false
        temporyLabel.textColor = UIColor.italyBrownColor()
        return temporyLabel
    }()
    

    lazy var vO2MaxLabel : UILabel = {
        var temporyLabel : UILabel = UILabel()
        temporyLabel.text = "VO2 max: 0"
        temporyLabel.font = UIFont(name: temporyLabel.font.fontName, size: 23)
        temporyLabel.translatesAutoresizingMaskIntoConstraints = false
        temporyLabel.textColor = UIColor.italyBrownColor()
        return temporyLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createRunningBleepTest()
        backgroundColor = .whiteColor()
        notificationObservers()
        addBleepTestLabels()
        setStatusBarBackgroundColor(UIColor.customBlueColor())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard  let statusBar = UIApplication.sharedApplication().valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else {
            return
        }
        statusBar.backgroundColor = color
    }
    
    func addBleepTestLabels(){
        let viewsDictionary = [
            "levelLabel":levelLabel,
            "lapLabel":lapLabel,
            "distanceLabel":distanceLabel,
            "vO2MaxLabel":vO2MaxLabel,
            "superview":self
        ]
        addSubview(levelLabel)
        addSubview(lapLabel)
        addSubview(distanceLabel)
        addSubview(vO2MaxLabel)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-100-[levelLabel]-30-[distanceLabel]-30-[vO2MaxLabel]-(>=200)-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[levelLabel]-(>=20)-[lapLabel]-30-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[levelLabel]-(>=20)-[lapLabel]-30-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[vO2MaxLabel]-30-|",
            options: NSLayoutFormatOptions.AlignAllBaseline,
            metrics: nil,
            views: viewsDictionary
            ))
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
            "H:|-30-[pauseButton(100)]-(>=20)-[stopButton(100)]-30-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[stopButton(100)]-120-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[pauseButton(100)]",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary))
    }
}

// MARK: Notifications
extension BleepTestView{
    private func notificationObservers(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(updateLevel(_:)),
            name: leveledUpNotificationKey,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(updateLap(_:)),
            name: lapedUpNotificationKey,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(bleepTestStoped(_:)),
            name: stopTestNotificationKey,
            object: nil)
    }
    
    func updateLevel(notification : NSNotification){
        let level = notification.userInfo!["level"]
        levelLabel.text = "Level: \(level!)"
    }
    
    func updateLap(notification : NSNotification){
        let level = notification.userInfo!["lap"]
        let distance = notification.userInfo!["distance"]
        let vO2Max = notification.userInfo!["VO2Max"]
        lapLabel.text = "Lap: \(level!)"
        distanceLabel.text = "Total distance: \(distance!)m"
        vO2MaxLabel.text = "VO2 max: \(vO2Max!)"
    }
    
    func bleepTestStoped(notification : NSNotification){
        stopButton.removeFromSuperview()
    }
}

// MARK: Button Actions
extension BleepTestView{
    func stopButtonAction(sender:UIButton!){
        stopButton.removeFromSuperview()
        NSNotificationCenter.defaultCenter().postNotificationName(
            stopTestNotificationKey,
            object: self)
    }
    func pauseButtonAction(sender:UIButton!){

    }
}
