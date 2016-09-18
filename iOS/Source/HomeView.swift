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
    
    func singleBleepTestView(){
        print("single")
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
