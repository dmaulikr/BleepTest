import UIKit
import DATAStack

open class BaseViewController: UIViewController {
    internal var fetcher: Fetcher
    internal var writer: Writer
    internal var dataStack: DATAStack?
    
    // MARK: - Initializers
    
    public init(fetcher: Fetcher, writer: Writer, dataStack: DATAStack) {
        self.fetcher = fetcher
        self.writer = writer
        self.dataStack = dataStack
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: StatusBar
extension BaseViewController{
    public func setStatusBarHidden(_ boolen: Bool){
        UIApplication.shared.isStatusBarHidden = boolen;
    }
}

//MARK: Keyboard dismissal
extension BaseViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
