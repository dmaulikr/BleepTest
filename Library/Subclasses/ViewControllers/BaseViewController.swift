import UIKit

public class BaseViewController: UIViewController {
    internal var fetcher: Fetcher
    internal var writer: Writer
    
    // MARK: - Initializers
    
    public init(fetcher: Fetcher, writer: Writer) {
        self.fetcher = fetcher
        self.writer = writer
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: StatusBar
extension BaseViewController{
    public func setStatusBarHidden(boolen: Bool){
        UIApplication.sharedApplication().statusBarHidden = boolen;
    }
}