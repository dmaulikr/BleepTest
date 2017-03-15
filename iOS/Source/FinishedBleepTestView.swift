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
        self.playerNameLabel.text = result.playerName
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
    }
    
    private func addLevelLabel() {
        self.addSubview(self.levelLabel)
    }
    
    private func addLapLabel() {
        self.addSubview(self.lapLabel)
    }
    
    private func addDistanceLabel() {
        self.addSubview(self.distanceLabel)
    }
    
    private func addVo2MaxLabel() {
        self.addSubview(self.vo2MaxLabel)
    }

}
