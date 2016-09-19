import UIKit

class HomeView: UIView {
    
    lazy var typeOfBleepTestSegment : UISegmentedControl = {
        let items = ["Single", "Team"]
        let segmentedControl = UISegmentedControl(items: items)
        let font = UIFont.systemFontOfSize(18)
        segmentedControl.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
        segmentedControl.addTarget(self, action: #selector(typeSegment(_:)), forControlEvents: UIControlEvents.ValueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.tintColor = UIColor.blueColor()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    lazy var singleRunnerLabel : MediumBlackLabel = {
        let label : MediumBlackLabel = MediumBlackLabel()
        label.text = "Runner"
        return label
    }()
    
    lazy var startButton : StartButton = {
        var temporyButton : StartButton = StartButton()
        temporyButton.addTarget(self, action: #selector(startButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return temporyButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStableUIComponentsToView()
        backgroundColor = .whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func typeSegment(sender:UISegmentedControl!){
        NSNotificationCenter.defaultCenter().postNotificationName(
            typeChangedNotificationKey,
            object: self)
        if(typeOfBleepTestSegment.selectedSegmentIndex == 0){
            singleBleepTestView()
        } else{
            teamBleepTestView()
        }
    }
    
    func addStableUIComponentsToView(){
        let viewsDictionary = [
            "typeOfBleepTestSegment":typeOfBleepTestSegment,
            "startButton":startButton,
            "superview":self
        ]
        
        addSubview(startButton)
        addSubview(typeOfBleepTestSegment)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-120-[typeOfBleepTestSegment(40)]-(>=300)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-20-[typeOfBleepTestSegment(>=280)]-20-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary))

        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[startButton(100)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[startButton(100)]-60-|",
            options: NSLayoutFormatOptions.AlignAllLeading,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[startButton(100)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        
        if(typeOfBleepTestSegment.selectedSegmentIndex == 0){
            singleBleepTestView()
        } else {
            teamBleepTestView()
        }
    }
    
    func singleBleepTestView(){
        let viewsDictionary = [
            "singleRunnerLabel" : singleRunnerLabel,
        ]
        singleRunnerLabel.hidden = false
        addSubview(singleRunnerLabel)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-180-[singleRunnerLabel(40)]-(>=300)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views:viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[singleRunnerLabel]-(>=30)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
    
    func teamBleepTestView(){
        print("team")
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
