import UIKit

class HomeController: BaseViewController {
    
    lazy var homeView : HomeView! = {
        let temporyPlayer = self.fetcher.fetchSelectedPlayer{_ in}
        var temporyView : HomeView = HomeView(frame: UIScreen.main.bounds, player: (temporyPlayer?.first))
        return temporyView
    }()
    
    let bleepTestNavigation: UINavigationController = {
        let temporyNavigation = UINavigationController()
        temporyNavigation.setNavigationBarHidden(true, animated: false)
        return temporyNavigation
    }()
    
    override func loadView() {
        self.title = "Bleep Test"
        self.view = self.homeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.homeView = nil
        self.view = self.homeView
        self.homeView.delegate = self
    }
}

//MARK: - HomeViewDelegate
extension HomeController : HomeViewDelegate{
    func didChangeButtonPressed(_ sender: HomeView) {
        let rootViewController = SelectUserTableViewController(fetcher: fetcher, writer: writer, dataStack: dataStack!)
        let navigationController = OrangeNavigationController(rootViewController: rootViewController)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    func didStartButtonPressed(_ sender: HomeView) {
        let bleepTestController = BleepTestController(fetcher: self.fetcher, writer: self.writer, dataStack: self.dataStack!)
        self.bleepTestNavigation.addChildViewController(bleepTestController)
        self.navigationController?.present(bleepTestNavigation, animated: true, completion: nil)
    }
}
