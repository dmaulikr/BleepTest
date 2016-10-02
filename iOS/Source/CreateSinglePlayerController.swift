import UIKit

class CreateSinglePlayerController: BaseViewController {
    
    override func loadView() {
        let view = CreateSinglePlayerView(frame: UIScreen.mainScreen().bounds)
        self.view = view

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
