import UIKit

class HomeController: BaseViewController {
    
    override func loadView() {
        let view = HomeView(frame: UIScreen.mainScreen().bounds)
        self.view = view
        self.title = "Bleep Test"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
