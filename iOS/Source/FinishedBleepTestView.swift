import UIKit

protocol FinishedBleepTestViewDelegate : class {
    func didCloseButtonPressed(_ sender: FinishedBleepTestView)
}

class FinishedBleepTestView: UIView {
    
    weak var delegate: FinishedBleepTestViewDelegate?
    
    internal var topLabel : MediumTitleLabel = {
        let temporyLabel = MediumTitleLabel()
        temporyLabel.font = UIFont.systemFont(ofSize: 16.0);
        temporyLabel.numberOfLines = 0;
        return temporyLabel
    }()
    
    internal var levelLabel: LargeContentLabel = {
        let temporyLabel = LargeContentLabel()
        temporyLabel.font = UIFont.systemFont(ofSize: 60.0);
        return temporyLabel
    }()
    
    internal var levelTitleLable: MediumTitleLabel = {
        let temporyLabel = MediumTitleLabel()
        temporyLabel.font = UIFont.systemFont(ofSize: 12.0);
        temporyLabel.text = "Level"
        return temporyLabel
    }()
    
    internal var lapLabel = LargeContentLabel()
    
    internal var lapTitleLable: MediumTitleLabel = {
        let temporyLabel = MediumTitleLabel()
        temporyLabel.font = UIFont.systemFont(ofSize: 12.0);
        temporyLabel.text = "Lap"
        return temporyLabel
    }()
    
    internal var bottomLabel: MediumBlackLabel = {
        let temporyLabel = MediumBlackLabel()
        temporyLabel.font = UIFont.systemFont(ofSize: 19.0);
        temporyLabel.numberOfLines = 0;
        temporyLabel.textAlignment = NSTextAlignment.center;
        return temporyLabel
    }()
    
    lazy var closeButton : RedButton = {
        var temporyButton : RedButton = RedButton()
        temporyButton.setTitle("Close", for: UIControlState())
        temporyButton.addTarget(self, action: #selector(closeButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return temporyButton
    }()
    

    //MARK: - Initializers
    public init(frame: CGRect, result: Result) {
        super.init(frame: frame)
        self.setLabels(to: result)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Populate labels
    
    private func setLabels(to value: Result) {
        self.levelLabel.text = value.level
        self.lapLabel.text = value.lap
        self.formatTopLabel(value.playerName)
        self.formatBottomLabel(value.distance, value.vo2Max)
    }
    
    
    private func formatTopLabel(_ playerName: String? = "") {
        var name:String
        if let nameCheck = playerName {
            name = " \(nameCheck)"
        } else {
             name = ""
        }

        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("Nice one")
            .bold(name, self.topLabel.font.pointSize)
            .normal(" you have finished a Bleep Test. This is your results!")
        self.topLabel.attributedText = formattedString
    }
    
    private func formatBottomLabel(_ distance: String, _ vo2Max: String) {
        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("You ran a total distance of ")
            .bold("\(distance)m ", self.bottomLabel.font.pointSize)
            .normal("and reached a ")
            .bold("maximal oxygen uptake ", self.bottomLabel.font.pointSize)
            .normal("of ")
            .bold(vo2Max, self.bottomLabel.font.pointSize)
        self.bottomLabel.attributedText = formattedString
    }
    
    
    //MARK: - Set up view methods
    
    private func setUpView() {
        self.backgroundColor = UIColor.white
        self.addTopLabel()
        self.addLevelLabel()
        self.addLevelTitleLabel()
        self.addLapLabel()
        self.addLapTitleLabel()
        self.addBottomLabel()
        self.addCloseButton()
    }
    
    private func addTopLabel() {
        self.addSubview(self.topLabel)
        
        let leading = NSLayoutConstraint(item: self.topLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 5.0)
        let trailing = NSLayoutConstraint(item: self.topLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -5.0)
        let top = NSLayoutConstraint(item: self.topLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 25.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addLevelLabel() {
        self.addSubview(self.levelLabel)
        
        let leading = NSLayoutConstraint(item: self.levelLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: self.levelLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: self.levelLabel, attribute: .top, relatedBy: .equal, toItem: self.topLabel, attribute: .bottom, multiplier: 1.0, constant: 50.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addLevelTitleLabel() {
        self.addSubview(self.levelTitleLable)
        
        let leading = NSLayoutConstraint(item: self.levelTitleLable, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: self.levelTitleLable, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: self.levelTitleLable, attribute: .top, relatedBy: .equal, toItem: self.levelLabel, attribute: .bottom, multiplier: 1.0, constant: 2.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addLapLabel() {
        self.addSubview(self.lapLabel)
        
        let leading = NSLayoutConstraint(item: self.lapLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: self.lapLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: self.lapLabel, attribute: .top, relatedBy: .equal, toItem: self.levelTitleLable, attribute: .bottom, multiplier: 1.0, constant: 20.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addLapTitleLabel() {
        self.addSubview(self.lapTitleLable)
        
        let leading = NSLayoutConstraint(item: self.lapTitleLable, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: self.lapTitleLable, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: self.lapTitleLable, attribute: .top, relatedBy: .equal, toItem: self.lapLabel, attribute: .bottom, multiplier: 1.0, constant: 2.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addBottomLabel() {
        self.addSubview(self.bottomLabel)
        
        let leading = NSLayoutConstraint(item: self.bottomLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 5.0)
        let trailing = NSLayoutConstraint(item: self.bottomLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -5.0)
        let top = NSLayoutConstraint(item: self.bottomLabel, attribute: .top, relatedBy: .equal, toItem: self.lapTitleLable, attribute: .bottom, multiplier: 1.0, constant: 60.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addCloseButton() {
        self.addSubview(self.closeButton)
        
        let leading = NSLayoutConstraint(item: self.closeButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 5.0)
        let trailing = NSLayoutConstraint(item: self.closeButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -5.0)
        let top = NSLayoutConstraint(item: self.closeButton, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self.bottomLabel, attribute: .bottom, multiplier: 1.0, constant: 20.0)
        let bottom = NSLayoutConstraint(item: self.closeButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -40.0)
        
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
}

//MARK: - Actions
extension FinishedBleepTestView {
    func closeButtonAction(_ sender:UIButton!) {
        self.delegate?.didCloseButtonPressed(self)
    }
}
