import UIKit

class CreateTeamController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = CreateTeamView()
        self.view = view
        view.delegate = self
    }
}


extension CreateTeamController : CreateTeamViewDelegate {

    func didCloseButtonPressed(_ sender: CreateTeamView) {
        
    }
    
    func didCreateButtonPressed(_ sender: CreateTeamView, name:NSString) {
        
    }
}

