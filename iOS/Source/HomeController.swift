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
        notificationObservers()
    }

}

//MARK: Notifications
extension HomeController{
    func notificationObservers(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(bleepTestStarted(_:)),
            name: startTestNotificationKey,
            object: nil)
    }
    
    func bleepTestStarted(notification: NSNotification){
        self.navigationController?.presentViewController(BleepTestController(fetcher: fetcher, writer: writer), animated: true, completion: nil)
    }
}


extension HomeController : HomeViewDelegate{
    func didChangeButtonPressed(sender: HomeView) {
        print("Change button pressed delegate")
    }
}
