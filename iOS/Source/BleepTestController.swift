import UIKit

class BleepTestController: BaseViewController {
    

    override func loadView() {
        let view = BleepTestView(frame: UIScreen.mainScreen().bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationObservers()
    }
    
    private func notificationObservers(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "bleepTestStarted:",
            name: startTestNotificationKey,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "bleepTestStoped:",
            name: stopTestNotificationKey,
            object: nil)
    }
    
    @objc private func bleepTestStoped(notification: NSNotification){
        
    }
    
    @objc private func bleepTestStarted(notification: NSNotification){
        let levels = fetcher.fetchTestLevels{_ in}
        print(levels.count)
    }
    
}
