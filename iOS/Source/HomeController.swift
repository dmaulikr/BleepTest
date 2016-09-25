import UIKit

class HomeController: BaseViewController {
    
    override func loadView() {
        let view = HomeView(frame: UIScreen.mainScreen().bounds)
        self.view = view
        self.title = "Bleep Test"
        view.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension HomeController : HomeViewDelegate{
    func didChangeButtonPressed(sender: HomeView) {
        print("Change button pressed delegate")
    }
    func didStartButtonPressed(sender: HomeView) {
        self.navigationController?.presentViewController(BleepTestController(fetcher: fetcher, writer: writer), animated: true, completion: nil)
    }
}
