import UIKit

class DetailTeamView: UIView {
    
    let titleLabel = UILabel()
    
    public init(frame: CGRect, _ team: Team) {
        super.init(frame: frame)
        self.populateLabels(team)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func populateLabels(_ team: Team) {
        self.titleLabel.text = team.name
    }
    
}
