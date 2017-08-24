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
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func didCreateButtonPressed(_ sender: CreateTeamView, name:NSString) {
        
    }
}

