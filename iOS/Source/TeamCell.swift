import UIKit

class TeamCell: UITableViewCell {
    
    let titleLabel: UILabel = UILabel()
    
    func configCellWith(_ team: Team) {
        titleLabel.text = team.name
    }
    
}
