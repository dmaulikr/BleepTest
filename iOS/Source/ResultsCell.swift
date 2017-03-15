import UIKit

class ResultsCell: UITableViewCell {
    
    static let Identifier: String = "ResultsCell"
    
    lazy var playerNameLabel : ResultsLargeLabel = {
        let label : ResultsLargeLabel = ResultsLargeLabel()
        label.textColor = UIColor.gray
        return label
    }()
    
    var levelLabel = ResultsLargeLabel()
    var lapLabel = ResultsLargeLabel()
    var vo2MaxLabel = ResultsSmallLabel()
    var distanceLabel = ResultsSmallLabel()
    
    func setUpCell(resutsCellContent: Result) {
        self.popuateCellLabels(resultCellContent: resutsCellContent)
        self.setUpView()
    }
    
    func popuateCellLabels(resultCellContent: Result) {
        self.levelLabel.text = resultCellContent.level
        self.lapLabel.text = resultCellContent.lap
        self.playerNameLabel.text = resultCellContent.playerName
        self.distanceLabel.text = resultCellContent.distance
        self.vo2MaxLabel.text = resultCellContent.vo2Max
    }
    
    func setUpView() {
        self.addPlayerNameLabel()
        self.addLevelLabel()
        self.addLapLabel()
        self.addDistanceLabel()
        self.addVo2MaxLabel()
    }
    
    func addPlayerNameLabel() {
        self.addSubview(self.playerNameLabel)
        let leading = NSLayoutConstraint(item: self.playerNameLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading,
                                         multiplier: 1.0, constant: 15.0)
        let top = NSLayoutConstraint(item: self.playerNameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top,
                                     multiplier: 1.0, constant: 10.0)
        NSLayoutConstraint.activate([leading, top])
    }
    
    func addLevelLabel() {
        self.addSubview(self.levelLabel)
        let leading = NSLayoutConstraint(item: self.levelLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading,
                                         multiplier: 1.0, constant: 15.0)
        let top = NSLayoutConstraint(item: self.levelLabel, attribute: .top, relatedBy: .equal, toItem: self.playerNameLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        NSLayoutConstraint.activate([leading, top])
    }
    
    func addLapLabel() {
        self.addSubview(self.lapLabel)
        let leading = NSLayoutConstraint(item: self.lapLabel, attribute: .trailing, relatedBy: .equal, toItem: self.levelLabel,
                                                 attribute: .trailing, multiplier: 1.0, constant: 75.0)
        let trailing = NSLayoutConstraint(item: self.lapLabel, attribute: .trailing, relatedBy: .equal, toItem: self,
                                                  attribute: .trailing, multiplier: 1.0, constant: -50.0)
        let top = NSLayoutConstraint(item: self.lapLabel, attribute: .top, relatedBy: .equal, toItem: self.playerNameLabel, attribute: .bottom,
                                              multiplier: 1.0, constant: 10.0)
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    func addDistanceLabel() {
        self.addSubview(self.distanceLabel)
        let leading = NSLayoutConstraint(item: self.distanceLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading,
                                         multiplier: 1.0, constant: 15.0)
        let top = NSLayoutConstraint(item: self.distanceLabel, attribute: .top, relatedBy: .equal, toItem: self.levelLabel, attribute: .bottom,
                                     multiplier: 1.0, constant: 10.0)
        NSLayoutConstraint.activate([leading, top])
    }
    
    func addVo2MaxLabel() {
        self.addSubview(self.vo2MaxLabel)
        let leading = NSLayoutConstraint(item: self.vo2MaxLabel, attribute: .trailing, relatedBy: .equal, toItem: self.distanceLabel,
                                         attribute: .trailing, multiplier: 1.0, constant: 75.0)
        let trailing = NSLayoutConstraint(item: self.vo2MaxLabel, attribute: .trailing, relatedBy: .equal, toItem: self,
                                          attribute: .trailing, multiplier: 1.0, constant: -20.0)
        let top = NSLayoutConstraint(item: self.vo2MaxLabel, attribute: .top, relatedBy: .equal, toItem: self.lapLabel, attribute: .bottom,
                                     multiplier: 1.0, constant: 10.0)
        NSLayoutConstraint.activate([leading, trailing, top])
    }
}
