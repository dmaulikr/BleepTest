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
        segmentedControl.tintColor = UIColor.customBlueColor()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    lazy var titleLabel : MediumBlackLabel = {
        let label : MediumBlackLabel = MediumBlackLabel()
        return label
    }()
    
    lazy var nameLabel : MedumBlueLabel = {
        let label : MedumBlueLabel = MedumBlueLabel()
        return label
    }()
    
    lazy var startButton : StartButton = {
        var temporyButton : StartButton = StartButton()
        temporyButton.addTarget(self, action: #selector(startButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return temporyButton
    }()
    
    lazy var changeButton : PinkRedOutlineButton = {
        var temporyButton : PinkRedOutlineButton = PinkRedOutlineButton()
        temporyButton.setTitle("Change", forState: UIControlState.Normal)
        temporyButton.addTarget(self, action: #selector(changeButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        temporyButton.titleLabel!.font =  UIFont(name: temporyButton.titleLabel!.font.fontName, size: 18)
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
}

//MARK: Static UI views which are alwas displayed
extension HomeView{
    func addStableUIComponentsToView(){
        let viewsDictionary = [
            "typeOfBleepTestSegment":typeOfBleepTestSegment,
            "startButton":startButton,
            "changeButton":changeButton,
            "titleLabel" : titleLabel,
            "nameLabel" : nameLabel,
            "superview":self
        ]
        
        addSubview(startButton)
        addSubview(typeOfBleepTestSegment)
        addSubview(changeButton)
        addSubview(titleLabel)
        addSubview(nameLabel)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-120-[typeOfBleepTestSegment(40)]-40-[titleLabel]-40-[changeButton(40)]-(>=100)-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[typeOfBleepTestSegment]-30-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[titleLabel]-(>=10)-[nameLabel]-30-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-60-[changeButton]-60-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views:viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[startButton(100)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[startButton(100)]-80-|",
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
}

//MARK: UISegmentedControl
extension HomeView{
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
    
    func singleBleepTestView(){
        titleLabel.text = "Runner:"
        nameLabel.text = "Me"
    }

    func teamBleepTestView(){
        nameLabel.text = "Manchester FC"
        titleLabel.text = "Team:"
    }

}

//MARK: Actions
extension HomeView{
    func startButtonAction(sender:UIButton!){
        NSNotificationCenter.defaultCenter().postNotificationName(
            startTestNotificationKey,
            object: self)
    }
    
    func changeButtonAction(sender:UIButton!){
        print("Change button pressed")
    }
}
