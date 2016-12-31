import UIKit

class CreateSinglePlayerController: BaseViewController {
    
    override func loadView() {
        let view = CreateSinglePlayerView(frame: UIScreen.mainScreen().bounds)
        self.view = view
        view.delegate = self
        setStatusBarHidden(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension CreateSinglePlayerController : CreateSinglePlayerViewDelegate {
    func didCloseButtonPressed(sender: CreateSinglePlayerView) {
        setStatusBarHidden(false)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func didCreateButtonPressed(sender: CreateSinglePlayerView, age:Int, userName:NSString){
        writer.createPlayer(userName as String, age:age)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}