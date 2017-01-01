import UIKit

class HomeController: BaseViewController {
    
    override func loadView() {
        self.title = "Bleep Test"
        let view = HomeView(frame: UIScreen.mainScreen().bounds, playerName: fetchPlayerName())
        self.view = view
    }
    
    override func viewDidAppear(animated: Bool) {
        let view = HomeView(frame: UIScreen.mainScreen().bounds, playerName: fetchPlayerName())
        self.view = view
        view.delegate = self
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
        self.navigationController?.presentViewController(CreateSinglePlayerController(fetcher: fetcher, writer: writer), animated: true, completion: nil)
    }
    func didStartButtonPressed(sender: HomeView) {
        self.navigationController?.presentViewController(BleepTestController(fetcher: fetcher, writer: writer), animated: true, completion: nil)
    }
}
