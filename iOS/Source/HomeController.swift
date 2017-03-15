import UIKit

class HomeController: BaseViewController {
    
    lazy var homeView : HomeView! = {
        let temporyPlayer = self.fetcher.fetchSelectedPlayer{_ in}
        var temporyView : HomeView = HomeView(frame: UIScreen.main.bounds, player: (temporyPlayer?.first))
        return temporyView
    }()
    
    lazy var beepTestController: BleepTestController = {
        let temporyController = BleepTestController(fetcher: self.fetcher, writer: self.writer, dataStack: self.dataStack!)
        return temporyController
    }()
    
    override func loadView() {
        self.title = "Bleep Test"
        self.view = self.homeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.homeView = nil
        self.view = self.homeView
        self.homeView.delegate = self
        self.beepTestController.delegate = self
    }
}

//MARK: HomeViewDelegate
extension HomeController : HomeViewDelegate{
    func didChangeButtonPressed(_ sender: HomeView) {
        let rootViewController = SelectUserTableViewController(fetcher: fetcher, writer: writer, dataStack: dataStack!)
        let navigationController = OrangeNavigationController(rootViewController: rootViewController)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    func didStartButtonPressed(_ sender: HomeView) {
        self.navigationController?.present(self.beepTestController, animated: true, completion: nil)
    }
}

extension HomeController : BleepTestControllerDelegate {
    func didTestFinish(_ sender: BleepTestController, result: Result) {
        let finishedBleepTestController = FinishedBleepTestController(result: result)
        self.navigationController?.present(finishedBleepTestController, animated: true, completion: nil)
    }
}
