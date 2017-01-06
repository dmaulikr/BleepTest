import UIKit

class HomeController: BaseViewController {
    
    lazy var homeView : HomeView = {
        var temporyView : HomeView = HomeView(frame: UIScreen.mainScreen().bounds, playerName: self.fetchPlayerName())
        return temporyView
    }()
    
    override func loadView() {
        self.title = "Bleep Test"
        self.view = self.homeView
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view = self.homeView
        self.homeView.delegate = self
    }
    
    func fetchPlayerName() -> String {
        let players = fetcher.fetchUsers{_ in}
        if (players.count > 0) {
            let player = players[players.count - 1]
            return player.username
        }
        return "No player"
    }
}

extension HomeController : HomeViewDelegate{
    
    func didChangeButtonPressed(sender: HomeView) {
        let rootViewController = SelectUserTableViewController(fetcher: fetcher, writer: writer, dataStack: dataStack!)
        rootViewController.delegate = self
        let navigationController = OrangeNavigationController(rootViewController: rootViewController)
        self.navigationController?.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func didStartButtonPressed(sender: HomeView) {
        self.navigationController?.presentViewController(BleepTestController(fetcher: fetcher, writer: writer, dataStack: dataStack!), animated: true, completion: nil)
    }
}

extension HomeController : SelectUserDelegate {
    
    func userSelected(sender: SelectUserTableViewController, user: Player) {
        self.homeView.setUsernameLabel(user.username)
    }
}
