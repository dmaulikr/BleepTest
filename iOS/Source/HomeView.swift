import UIKit

class HomeView: UIView {
    
    lazy var typeOfBleepTestSegment : UISegmentedControl = {
        let items = ["Single", "Team"]
        let segmentedControl = UISegmentedControl(items: items)
        let font = UIFont.systemFontOfSize(25)
        segmentedControl.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.tintColor = UIColor.italyBrownColor()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    lazy var lapDistanceTitleLabel : MediumTitleLabel = {
        var temporyLabel : MediumTitleLabel = MediumTitleLabel()
        temporyLabel.text = "Lap distance"
        return temporyLabel
    }()
    
    lazy var lapDistanceSegment : UISegmentedControl = {
        let items = ["15m", "20m"]
        let segmentedControl = UISegmentedControl(items: items)
        let font = UIFont.systemFontOfSize(18)
        segmentedControl.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.tintColor = UIColor.italyBrownColor()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    lazy var startButton : StartButton = {
        var temporyButton : StartButton = StartButton()
        temporyButton.addTarget(self, action: #selector(startButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return temporyButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUIComponentsToView()
        backgroundColor = .whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUIComponentsToView(){
        let viewsDictionary = [
            "lapDistanceTitleLabel":lapDistanceTitleLabel,
            "lapDistanceSegment":lapDistanceSegment,
            "startButton":startButton,
            "typeOfBleepTestSegment":typeOfBleepTestSegment,
            "superview":self
        ]
        addSubview(typeOfBleepTestSegment)
        addSubview(lapDistanceTitleLabel)
        addSubview(lapDistanceSegment)
        addSubview(startButton)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[startButton]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[startButton(100)]-80-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[lapDistanceSegment(35)]-260-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[startButton(100)]",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-80-[typeOfBleepTestSegment(40)]-(>=300)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[typeOfBleepTestSegment(>=280)]-10-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[lapDistanceTitleLabel]-(>=20)-[lapDistanceSegment(100)]-20-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary
            ))
    }
}

//MARK: Actions
extension HomeView{
    func startButtonAction(sender:UIButton!){
        NSNotificationCenter.defaultCenter().postNotificationName(
            startTestNotificationKey,
            object: self)
    }
}
