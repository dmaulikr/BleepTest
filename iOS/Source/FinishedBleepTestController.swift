import UIKit

class FinishedBleepTestController: UIViewController {

    internal var result: Result
    
    lazy internal var rootView: FinishedBleepTestView = {
        var temporyView = FinishedBleepTestView(frame: UIScreen.main.bounds, result: self.result)
        temporyView.delegate = self
        return temporyView
    }()
    
    // MARK: - Initializers
    public init(result: Result){
        self.result = result
        super.init(nibName: nil, bundle: nil)
        self.view = self.rootView
        self.setStatusBarHidden(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func close() {
        self.setStatusBarHidden(false)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setStatusBarHidden(_ boolen: Bool){
        UIApplication.shared.isStatusBarHidden = boolen;
    }
    
}

//MARK: - FinishedBleepTestViewDelegate
extension FinishedBleepTestController: FinishedBleepTestViewDelegate {
    
    func didCloseButtonPressed(_ sender: FinishedBleepTestView){
        self.close()
    }
}
