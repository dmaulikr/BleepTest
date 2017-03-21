import UIKit

protocol HomeViewDelegate: class {
    func didChangeButtonPressed(_ sender: HomeView)
    func didStartButtonPressed(_ sender: HomeView)
}

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    var player: Player?
    
    lazy var topLabel : MediumTitleLabel = {
        let temporyLabel = MediumTitleLabel()
        temporyLabel.font = UIFont.systemFont(ofSize: 16.0);
        temporyLabel.numberOfLines = 0;
        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("Welcome to the BleepTest app. This app is set up for a ")
            .bold("20m ", temporyLabel.font.pointSize)
            .normal("bleep test. Make sure your markers are set up at the correct distance!")
        temporyLabel.attributedText = formattedString
        return temporyLabel
    }()
    
    lazy var titleLabel : MediumBlackLabel = {
        let label : MediumBlackLabel = MediumBlackLabel()
        label.text = "Runner:"
        return label
    }()
    
    var nameLabel = MedumBlueLabel()
    
    lazy var startButton : BlueButton = {
        var temporyButton : BlueButton = BlueButton()
        temporyButton.setTitle("Start", for: UIControlState())
        temporyButton.addTarget(self, action: #selector(startButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return temporyButton
    }()
    
    lazy var changeButton : PinkRedOutlineButton = {
        var temporyButton : PinkRedOutlineButton = PinkRedOutlineButton()
        temporyButton.setTitle("Change", for: UIControlState())
        temporyButton.addTarget(self, action: #selector(changeButtonAction(_:)), for: UIControlEvents.touchUpInside)
        temporyButton.titleLabel!.font =  UIFont(name: temporyButton.titleLabel!.font.fontName, size: 12)
        return temporyButton
    }()
    
    init(frame: CGRect, player: Player?) {
        self.player = player
        super.init(frame: frame)
        populateUserInterface()
        addStableUIComponentsToView()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateUserInterface(){
        if((self.player) != nil){
            self.nameLabel.text = self.player!.username
        } else {
            self.nameLabel.text = "No runner"
        }
    }

//MARK: Static UI views which are alwas displayed

    func addStableUIComponentsToView(){
        let viewsDictionary = [
            "topLabel": topLabel,
            "startButton":startButton,
            "changeButton":changeButton,
            "titleLabel" : titleLabel,
            "nameLabel" : nameLabel,
            "superview":self
        ] as [String : Any]
        
        addSubview(topLabel)
        addSubview(startButton)
        addSubview(changeButton)
        addSubview(titleLabel)
        addSubview(nameLabel)
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[titleLabel]-1-[changeButton(40)]",
            options: NSLayoutFormatOptions.alignAllLeft,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-80-[topLabel]-50-[titleLabel]-(>=150)-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(>=150)-[startButton(100)]-120-|",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-30-[titleLabel]-(>=10)-[nameLabel]-30-|",
            options: NSLayoutFormatOptions.alignAllCenterY,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[superview]-(<=1)-[startButton(100)]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary
            ))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[topLabel]-10-|",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary
        ))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:[startButton(100)]",
            options: NSLayoutFormatOptions.alignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
}

//MARK: Actions
extension HomeView{
    func startButtonAction(_ sender:UIButton!){
        delegate?.didStartButtonPressed(self)
    }
    
    func changeButtonAction(_ sender:UIButton!){
        delegate?.didChangeButtonPressed(self)
    }
}
