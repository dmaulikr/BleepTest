import UIKit

class TeamCell: UITableViewCell {
    
    let titleLabel: UILabel = UILabel()
    static let Identifier: String = NSStringFromClass(TeamCell.self)
    
    func configCellWith(_ team: Team) {
        titleLabel.text = team.name
    }
    
}
