import UIKit

class FinishedBleepTestController: UIViewController {

    internal var result: Result
    
    lazy internal var rootView: FinishedBleepTestView = {
        var temporyView = FinishedBleepTestView(frame: UIScreen.main.bounds, result: self.result)
        return temporyView
    }()
    
    // MARK: - Initializers
    public init(result: Result){
        self.result = result
        super.init(nibName: nil, bundle: nil)
        self.view = self.rootView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
