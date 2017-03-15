import UIKit

class FinishedBleepTestView: UIView {
    
    internal var playerNameLabel = UILabel()
    internal var levelLabel = UILabel()
    internal var lapLabel = UILabel()
    internal var vo2MaxLabel = UILabel()
    internal var distanceLabel = UILabel()

    //MARK: Initializers
    public init(frame: CGRect, result: Result) {
        super.init(frame: frame)
        self.setLabelsValues(result: result)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Set up view methods
    
    private func setLabelsValues(result: Result) {
        self.levelLabel.text = result.level
        self.lapLabel.text = result.lap
        self.playerNameLabel.text = "Nice one \(result.playerName) you have finished a Bleep Test. This is your results!"
        self.distanceLabel.text = result.distance
        self.vo2MaxLabel.text = result.vo2Max
    }
    
    private func setUpView() {
        self.addPlayerNameLabel()
        self.addLevelLabel()
        self.addLapLabel()
        self.addDistanceLabel()
        self.addVo2MaxLabel()
    }
    
    private func addPlayerNameLabel() {
        self.addSubview(self.playerNameLabel)
        
        let leading = NSLayoutConstraint(item: self.playerNameLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 50.0)
        let trailing = NSLayoutConstraint(item: self.playerNameLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -50.0)
        let top = NSLayoutConstraint(item: self.playerNameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 50.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addLevelLabel() {
        self.addSubview(self.levelLabel)
        
        let leading = NSLayoutConstraint(item: self.levelLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 50.0)
        let trailing = NSLayoutConstraint(item: self.levelLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -50.0)
        let top = NSLayoutConstraint(item: self.levelLabel, attribute: .top, relatedBy: .equal, toItem: self.playerNameLabel, attribute: .top, multiplier: 1.0, constant: 50.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addLapLabel() {
        self.addSubview(self.lapLabel)
        
        let leading = NSLayoutConstraint(item: self.lapLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 50.0)
        let trailing = NSLayoutConstraint(item: self.lapLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -50.0)
        let top = NSLayoutConstraint(item: self.lapLabel, attribute: .top, relatedBy: .equal, toItem: self.levelLabel, attribute: .top, multiplier: 1.0, constant: 50.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    private func addDistanceLabel() {
        self.addSubview(self.distanceLabel)
        
        let leading = NSLayoutConstraint(item: self.distanceLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 15.0)
        let top = NSLayoutConstraint(item: self.distanceLabel, attribute: .top, relatedBy: .equal, toItem: self.lapLabel, attribute: .bottom, multiplier: 1.0, constant: 50.0)
        
        NSLayoutConstraint.activate([leading, top])
    }
    
    private func addVo2MaxLabel() {
        self.addSubview(self.vo2MaxLabel)
        
        let leading = NSLayoutConstraint(item: self.vo2MaxLabel, attribute: .trailing, relatedBy: .equal, toItem: self.distanceLabel, attribute: .trailing, multiplier: 1.0, constant: 75.0)
        let trailing = NSLayoutConstraint(item: self.vo2MaxLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -20.0)
        let top = NSLayoutConstraint(item: self.vo2MaxLabel, attribute: .top, relatedBy: .equal, toItem: self.lapLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        
        NSLayoutConstraint.activate([leading, trailing, top])
    }

}
