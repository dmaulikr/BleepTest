import UIKit

class FinishedBleepTestView: UIView {
    
    internal var vo2MaxLabel = UILabel()
    internal var distanceLabel = UILabel()
    internal var topLabel : MediumTitleLabel = {
        let temporyLabel = MediumTitleLabel()
        temporyLabel.font = UIFont.systemFont(ofSize: 16.0);
        temporyLabel.numberOfLines = 0;
    
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
    
        temporyLabel.textAlignment = NSTextAlignment.center;
        return temporyLabel
    }()

    //MARK: - Initializers
    public init(frame: CGRect, result: Result) {
        super.init(frame: frame)
        self.setLabelsValues(result: result)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Populate labels
    
    private func setLabelsValues(result: Result) {
        self.levelLabel.text = result.level
        self.lapLabel.text = result.lap
        self.distanceLabel.text = result.distance
        self.formatPlayerNameLabel(string: result.playerName)
        self.vo2MaxLabel.text = result.vo2Max
        self.formatTopLabel(result.playerName)
    }
    
    
    private func formatTopLabel(_ playerName: String) {
        let formattedString = NSMutableAttributedString()
        formattedString
            .normal("Nice one ")
            .bold(playerName, self.topLabel.font.pointSize)
            .normal(" you have finished a Bleep Test. This is your results!")
        self.topLabel.attributedText = formattedString
    }
    
    
    
    //MARK: - Set up view methods
    
    private func setUpView() {
        self.backgroundColor = UIColor.white
        self.addTopLabel()
        self.addLevelLabel()
        self.addLevelTitleLabel()
        self.addLapLabel()
        self.addDistanceLabel()
        self.addVo2MaxLabel()
        self.addLapTitleLabel()
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
        let top = NSLayoutConstraint(item: self.levelLabel, attribute: .top, relatedBy: .equal, toItem: self.topLabel, attribute: .bottom, multiplier: 1.0, constant: 40.0)
        
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
    
    private func addDistanceLabel() {
        self.addSubview(self.distanceLabel)
    private func addLapTitleLabel() {
        self.addSubview(self.lapTitleLable)
        
        let leading = NSLayoutConstraint(item: self.lapTitleLable, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: self.lapTitleLable, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: self.lapTitleLable, attribute: .top, relatedBy: .equal, toItem: self.lapLabel, attribute: .bottom, multiplier: 1.0, constant: 2.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addVo2MaxLabel() {
        self.addSubview(self.vo2MaxLabel)
        
        let leading = NSLayoutConstraint(item: self.vo2MaxLabel, attribute: .trailing, relatedBy: .equal, toItem: self.distanceLabel, attribute: .trailing, multiplier: 1.0, constant: 75.0)
        let trailing = NSLayoutConstraint(item: self.vo2MaxLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0)
        let top = NSLayoutConstraint(item: self.vo2MaxLabel, attribute: .top, relatedBy: .equal, toItem: self.lapLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }

}
