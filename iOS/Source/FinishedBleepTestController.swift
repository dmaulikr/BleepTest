import UIKit

class FinishedBleepTestController: BaseViewController {

    lazy var rootView: FinishedBleepTestView = {
        var temporyView = FinishedBleepTestView(frame: UIScreen.main.bounds)
        return temporyView
    }()
    
    override func viewDidLoad() {
        self.view = self.rootView
    }

}
