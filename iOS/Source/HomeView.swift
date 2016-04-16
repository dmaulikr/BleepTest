import UIKit

class HomeView: UIView {
    
    lazy var lapDistanceTitleLabel : MediumTitleLabel = {
        var temporyLabel : MediumTitleLabel = MediumTitleLabel()
        temporyLabel.text = "Lap distance"
        return temporyLabel
    }()
    
    lazy var lapDistanceLabel : MediumContentLabel = {
        var temporyLabel : MediumContentLabel = MediumContentLabel()
        temporyLabel.text = "20m"
        return temporyLabel
    }()
    
    lazy var startButton : StartButton = {
        var temporyButton : StartButton = StartButton()
        temporyButton.addTarget(self, action: #selector(startButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        temporyButton.translatesAutoresizingMaskIntoConstraints = false
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
            "lapDistanceLabel":lapDistanceLabel,
            "startButton":startButton,
            "superview":self
        ]
        addSubview(lapDistanceTitleLabel)
        addSubview(lapDistanceLabel)
        addSubview(startButton)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[startButton]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[lapDistanceTitleLabel]-80-[startButton(100)]-80-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(>=50)-[lapDistanceLabel]-260-|",
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
            "H:|-20-[lapDistanceTitleLabel]-(>=80)-|",
            options: NSLayoutFormatOptions.AlignAllCenterY,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-(>=80)-[lapDistanceLabel]-20-|",
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
