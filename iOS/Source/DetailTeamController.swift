import UIKit

class DetailTeamController: UIViewController {
    
    var team: Team!
    var rootView: DetailTeamView!
    
    override func viewWillAppear(_ animated: Bool) {
        guard let team = team else { return }
        self.rootView = DetailTeamView(frame: UIScreen.main.bounds, team)
        self.view = self.rootView
    }
    
}
