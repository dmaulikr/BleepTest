import UIKit

struct ResultsCellContent {
    var level: String
    var lap: String
    var vo2Max: String
    var distance: String
    var playerName: String
}

class ResultsCell: UITableViewCell {
    
    static let Identifier: String = "ResultsCell"
    
    var levelLabel = MediumBlackLabel()
    var lapLabel = MediumBlackLabel()
    var playerNameLabel = MediumBlackLabel()
    var vo2MaxLabel = SmallTitleLabel()
    var distanceLabel = SmallTitleLabel()
    
    func setUpCell(resutsCellContent: ResultsCellContent) {
        self.popuateCellLabels(resutsCellContent: resutsCellContent)
    }
    
    func popuateCellLabels(resutsCellContent: ResultsCellContent) {
        self.levelLabel.text = resutsCellContent.level
        self.lapLabel.text = resutsCellContent.lap
        self.playerNameLabel.text = resutsCellContent.playerName
        self.distanceLabel.text = resutsCellContent.distance
        self.vo2MaxLabel.text = resutsCellContent.vo2Max
    }
    
}
