import UIKit

class CreateSinglePlayerController: BaseViewController {
    override func loadView() {
        let view = CreateSinglePlayerView(frame: UIScreen.main.bounds)
        self.view = view
        view.delegate = self
        self.setStatusBarHidden(true)
        self.hideKeyboardWhenTappedAround()
    }
}

extension CreateSinglePlayerController : CreateSinglePlayerViewDelegate {
    func didCloseButtonPressed(_ sender: CreateSinglePlayerView) {
        view.endEditing(true)
        setStatusBarHidden(false)
        self.dismiss(animated: true, completion: nil)
    }
    func didCreateButtonPressed(_ sender: CreateSinglePlayerView, age:Int, userName:NSString) {
        view.endEditing(true)
        setStatusBarHidden(false)
        writer.createPlayer(userName as String, age:age)
        self.dismiss(animated: true, completion: nil)
    }
}
