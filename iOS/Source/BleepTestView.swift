import UIKit

protocol BleepTestViewDelegate: class {
    func didStopButtonPressed(sender: BleepTestView)
}

class BleepTestView: UIView {
    
    let cornerRadius : CGFloat = 5
    let borderWidth : CGFloat = 2
    weak var delegate:BleepTestViewDelegate?

    lazy var lapProgressIndicator : LapProgressIndicator = {
        let circleWidth = CGFloat(260)
        let circleHeight = circleWidth
        var temporyView : LapProgressIndicator = LapProgressIndicator()
        temporyView = LapProgressIndicator(frame: CGRect(x: 0, y: 0, width: circleWidth, height: circleHeight))
        return temporyView
    }()
    
    lazy var levelProgressIndicator : LevelProgressIndicator = {
        let circleWidth = CGFloat(80)
        let circleHeight = circleWidth
        var temporyView : LevelProgressIndicator = LevelProgressIndicator()
        temporyView = LevelProgressIndicator(frame: CGRect(x: 0, y: 0, width: circleWidth, height: circleHeight))
        return temporyView
    }()
    
    lazy var circleView : CircleView = {
        let circleWidth = CGFloat(60)
        let circleHeight = circleWidth
        var temporyView : CircleView = CircleView()
        temporyView = CircleView(frame: CGRect(x: 0, y: 0, width: circleWidth, height: circleHeight))
        return temporyView
    }()
    
    lazy var stopButton : StopButton = {
        var temporyButton : StopButton = StopButton()
        temporyButton.addTarget(self, action: #selector(stopButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return temporyButton
    }()

    lazy var pauseButton : PauseButton = {
        var temporyButton : PauseButton = PauseButton()
        temporyButton.addTarget(self, action: #selector(pauseButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return temporyButton
    }()
    
    lazy var levelTitleLabel : SmallTitleLabel = {
        var temporyLabel : SmallTitleLabel = SmallTitleLabel()
        temporyLabel.text = "Level"
        return temporyLabel
    }()
    
    lazy var levelLabel : LargeContentLabel = {
        var temporyLabel : LargeContentLabel = LargeContentLabel()
        temporyLabel.text = "0"
        return temporyLabel
    }()
    
    lazy var lapTitleLabel : SmallTitleLabel = {
        var temporyLabel : SmallTitleLabel = SmallTitleLabel()
        temporyLabel.text = "Lap"
        return temporyLabel
    }()
    
    lazy var lapLabel : LargeContentLabel = {
        var temporyLabel : LargeContentLabel = LargeContentLabel()
        temporyLabel.text = "0"
        return temporyLabel
    }()
    
    lazy var distanceTitleLabel : SmallTitleLabel = {
        var temporyLabel : SmallTitleLabel = SmallTitleLabel()
        temporyLabel.text = "Distance"
        return temporyLabel
    }()
    
    lazy var distanceLabel : MediumBlackLabel = {
        var temporyLabel : MediumBlackLabel = MediumBlackLabel()
        temporyLabel.text = "0m"
        return temporyLabel
    }()
    
    lazy var vO2MaxTitleLabel : SmallTitleLabel = {
        var temporyLabel : SmallTitleLabel = SmallTitleLabel()
        temporyLabel.text = "Maximum Oxygen Uptake"
        return temporyLabel
    }()

    lazy var vO2MaxLabel : MediumBlackLabel = {
        var temporyLabel : MediumBlackLabel = MediumBlackLabel()
        temporyLabel.text = "0"
        return temporyLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createRunningBleepTest()
        backgroundColor = .whiteColor()
        notificationObservers()
        addStatsLabels()
        addLevelsLables()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addStatsLabels(){
        let viewsDictionary = [
            "distanceLabel":distanceLabel,
            "vO2MaxLabel":vO2MaxLabel,
            "distanceTitleLabel":distanceTitleLabel,
            "vO2MaxTitleLabel":vO2MaxTitleLabel,
            "superview":self
        ]

        addSubview(distanceLabel)
        addSubview(vO2MaxLabel)
        addSubview(distanceTitleLabel)
        addSubview(vO2MaxTitleLabel)

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-40-[distanceTitleLabel]-10-[distanceLabel]-(>=200)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-40-[distanceLabel]-(>=20)-[vO2MaxLabel]-40-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-40-[distanceTitleLabel]-(>=20)-[vO2MaxTitleLabel]-35-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary
            ))
    }
    
    //This is the view when the bleep test is running
    func createRunningBleepTest(){
        addLapProgressIndicator()
        addButtonsToView()
        addLevelProgressIndicator()
    }
    
    func addLapProgressIndicator(){
        let viewsDictionary = [
            "lapProgressIndicator":lapProgressIndicator,
            "superview":self
        ]
        
        addSubview(lapProgressIndicator)
        
        //setting the size of the LapProgressIndicator View
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[lapProgressIndicator(260)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[lapProgressIndicator(260)]",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[superview]-(<=1)-[lapProgressIndicator]",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[lapProgressIndicator]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
    
    func addButtonsToView(){
        let viewsDictionary = [
            "stopButton":stopButton,
            "superview":self
        ]
        
        addSubview(stopButton)

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[stopButton(100)]-30-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[stopButton(100)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[stopButton(100)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
    
    func addLevelProgressIndicator(){
        let viewsDictionary = [
            "levelProgressIndicator":levelProgressIndicator,
            "superview":self
        ]
        
        addSubview(levelProgressIndicator)
        
        //setting the size of the LapProgressIndicator View
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[levelProgressIndicator(80)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[levelProgressIndicator(80)]",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        
        //Centering the LapProgressIndicator View
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[superview]-(<=1)-[levelProgressIndicator]",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[levelProgressIndicator]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
    
    func addLevelsLables(){
        let viewsDictionary = [
            "circleView":circleView,
            "levelLabel" : levelLabel,
            "lapLabel" : lapLabel,
            "levelTitleLabel":levelTitleLabel,
            "lapTitleLabel":lapTitleLabel,
            "superview":self
        ]
        
        addSubview(circleView)
        addSubview(levelLabel)
        addSubview(lapLabel)
        addSubview(levelTitleLabel)
        addSubview(lapTitleLabel)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-(>=40)-[levelLabel]-40-[circleView(60)]-40-[lapLabel]-(>=40)-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=0)-[levelTitleLabel]-5-[levelLabel]-(>=0)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=0)-[lapTitleLabel]-5-[lapLabel]-(>=0)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[circleView(60)]",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[superview]-(<=1)-[circleView]",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[circleView]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
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
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(lapStarted(_:)),
            name: startedNewLapNotificationKey,
            object: nil)
    }
    
    func updateLevel(notification : NSNotification){
        let level = notification.userInfo!["level"]
        let numberOfLaps = notification.userInfo!["numberOfLaps"]?.doubleValue
        let lapTime = notification.userInfo!["lapTime"]?.doubleValue
        levelLabel.text = level as? String
        let levelTime = numberOfLaps! * lapTime!
        levelProgressIndicator.animateCircle(levelTime)
    }
    
    func updateLap(notification : NSNotification){
        let lap = notification.userInfo!["lap"]
        let distance = notification.userInfo!["distance"]
        let vO2Max = notification.userInfo!["VO2Max"]
        lapLabel.text = lap as? String
        distanceLabel.text = "\(distance!)m"
        vO2MaxLabel.text = "\(vO2Max!)"
    }
    
    func bleepTestStoped(notification : NSNotification){
        stopButton.removeFromSuperview()
    }
    
    func lapStarted(notification: NSNotification){
        let lap = notification.userInfo!["lap"]?.doubleValue
        lapProgressIndicator.animateCircle(lap!)
    }
}

// MARK: Button Actions
extension BleepTestView{
    func stopButtonAction(sender:UIButton!){
        delegate?.didStopButtonPressed(self)
    }
    
    func pauseButtonAction(sender:UIButton!){
        // TODO: Pause Button Action
    }
}
