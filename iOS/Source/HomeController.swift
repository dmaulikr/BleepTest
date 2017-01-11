import UIKit

class HomeController: BaseViewController {
    
    private var player: Player!
    lazy var homeView : HomeView! = {
        let temporyPlayer = self.fetcher.fetchSelectedPlayer{_ in}
        var temporyView : HomeView = HomeView(frame: UIScreen.mainScreen().bounds, player: (temporyPlayer?.first))
        return temporyView
    }()
    
    override func loadView() {
        self.title = "Bleep Test"
        self.view = self.homeView
    }
    
    override func viewDidAppear(animated: Bool) {
        self.homeView = nil
        self.view = self.homeView
        self.homeView.delegate = self
    }
    
    func fetchPlayerName() -> String {
        let players = fetcher.fetchUsers{_ in}
        if (players.count > 0) {
            let player = players[players.count - 1]
            self.player = player
            return player.username
        }
        return "No player"
    }
}

//MARK: HomeViewDelegate
extension HomeController : HomeViewDelegate{
    func didChangeButtonPressed(sender: HomeView) {
        let rootViewController = SelectUserTableViewController(fetcher: fetcher, writer: writer, dataStack: dataStack!)
        let navigationController = OrangeNavigationController(rootViewController: rootViewController)
        self.navigationController?.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func didStartButtonPressed(sender: HomeView) {
        let beepTestController = BleepTestController(fetcher: fetcher, writer: writer, dataStack: dataStack!)
        self.navigationController?.presentViewController(beepTestController, animated: true, completion: nil)
    }
}
