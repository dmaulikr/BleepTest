import UIKit
import Sync

open class BaseCollectionViewController: UICollectionViewController {
    internal var fetcher: Fetcher
    internal var writer: Writer
    internal var dataStack: DataStack?
    
    // MARK: - Initializers
    
    public init(fetcher: Fetcher, writer: Writer, dataStack: DataStack) {
        self.fetcher = fetcher
        self.writer = writer
        self.dataStack = dataStack
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Status Bar
extension BaseCollectionViewController{
    public func setStatusBarHidden(_ boolen: Bool){
        UIApplication.shared.isStatusBarHidden = boolen;
    }
}

//MARK: Keyboard dismissal
extension BaseCollectionViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
