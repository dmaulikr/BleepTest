import UIKit

protocol HomeViewDelegate: class {
    func didChangeButtonPressed(sender: HomeView)
    func didStartButtonPressed(sender: HomeView)
}

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    var playerName: String?
    
    lazy var titleLabel : MediumBlackLabel = {
        let label : MediumBlackLabel = MediumBlackLabel()
        label.text = "Runner:"
        return label
    }()
    
    var nameLabel = MedumBlueLabel()
    
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
    
    init(frame: CGRect, playerName: String) {
        self.playerName = playerName
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
            "startButton":startButton,
            "changeButton":changeButton,
            "titleLabel" : titleLabel,
            "nameLabel" : nameLabel,
            "superview":self
        ]
        
        addSubview(startButton)
        addSubview(changeButton)
        addSubview(titleLabel)
        addSubview(nameLabel)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-120-[titleLabel]-50-[changeButton(40)]-50-[startButton(100)]-(>=80)-|",
            options: NSLayoutFormatOptions(rawValue: 0),
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
            "H:[startButton(100)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
    
    }
}

//MARK: Actions
extension HomeView{
    func startButtonAction(sender:UIButton!){
        delegate?.didStartButtonPressed(self)
    }
    
    func changeButtonAction(sender:UIButton!){
        delegate?.didChangeButtonPressed(self)
    }
}
