import UIKit

protocol BleepTestViewDelegate: class {
    func didStopButtonPressed(_ sender: BleepTestView)
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
        temporyButton.addTarget(self, action: #selector(stopButtonAction(_:)), for: UIControlEvents.touchUpInside)
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
        backgroundColor = .white
        addStatsLabels()
        addLevelsLables()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newLap(_ lap: String, lapTime: Double) {
        self.lapLabel.text = lap
        self.lapProgressIndicator.animateCircle(lapTime)
    }
    
    func newLevel(_ level: String, levelTime: Double) {
        self.levelLabel.text = level
        self.levelProgressIndicator.animateCircle(levelTime)
    }
    
    func updateVO2Max(_ vO2Max: String) {
        self.vO2MaxLabel.text = vO2Max
    }
    
    func updateDistanceLabel(_ distance: String) {
        distanceLabel.text = distance
    }
    
    func addStatsLabels(){
        let viewsDictionary = [
            "distanceLabel":distanceLabel,
            "vO2MaxLabel":vO2MaxLabel,
            "distanceTitleLabel":distanceTitleLabel,
            "vO2MaxTitleLabel":vO2MaxTitleLabel,
            "superview":self
        ] as [String : Any]

        addSubview(distanceLabel)
        addSubview(vO2MaxLabel)
        addSubview(distanceTitleLabel)
        addSubview(vO2MaxTitleLabel)

        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-40-[distanceTitleLabel]-10-[distanceLabel]-(>=200)-|",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-40-[distanceLabel]-(>=20)-[vO2MaxLabel]-40-|",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-40-[distanceTitleLabel]-(>=20)-[vO2MaxTitleLabel]-35-|",
            options: NSLayoutFormatOptions.alignAllCenterY,
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
        ] as [String : Any]
        
        addSubview(lapProgressIndicator)
        
        //setting the size of the LapProgressIndicator View
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[lapProgressIndicator(260)]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[lapProgressIndicator(260)]",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superview]-(<=1)-[lapProgressIndicator]",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[lapProgressIndicator]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
    
    func addButtonsToView(){
        let viewsDictionary = [
            "stopButton":stopButton,
            "superview":self
        ] as [String : Any]
        
        addSubview(stopButton)

        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(>=50)-[stopButton(100)]-30-|",
            options: NSLayoutFormatOptions.alignAllLeading,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[stopButton(100)]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[stopButton(100)]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
    
    func addLevelProgressIndicator(){
        let viewsDictionary = [
            "levelProgressIndicator":levelProgressIndicator,
            "superview":self
        ] as [String : Any]
        
        addSubview(levelProgressIndicator)
        
        //setting the size of the LapProgressIndicator View
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[levelProgressIndicator(80)]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[levelProgressIndicator(80)]",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        
        //Centering the LapProgressIndicator View
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superview]-(<=1)-[levelProgressIndicator]",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[levelProgressIndicator]",
            options: NSLayoutFormatOptions.alignAllCenterX,
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
        ] as [String : Any]
        
        addSubview(circleView)
        addSubview(levelLabel)
        addSubview(lapLabel)
        addSubview(levelTitleLabel)
        addSubview(lapTitleLabel)
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(>=40)-[levelLabel]-40-[circleView(60)]-40-[lapLabel]-(>=40)-|",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(>=0)-[levelTitleLabel]-5-[levelLabel]-(>=0)-|",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(>=0)-[lapTitleLabel]-5-[lapLabel]-(>=0)-|",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[circleView(60)]",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[superview]-(<=1)-[circleView]",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[circleView]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
}

// MARK: Button Actions
extension BleepTestView{
    func stopButtonAction(_ sender:UIButton!){
        delegate?.didStopButtonPressed(self)
    }
}
