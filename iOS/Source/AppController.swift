import UIKit
import DATAStack

@UIApplicationMain
class AppController: UIResponder {

    var window: UIWindow?
    var navController: UINavigationController?
    
    fileprivate lazy var dataStack: DATAStack = {
        let data = DATAStack(modelName: "iOS", bundle: Bundle.main, storeType:.sqLite)
        return data
    }()
    
    fileprivate lazy var fetcher: Fetcher = {
        let fetcher = Fetcher(dataStack: self.dataStack)
        return fetcher
    }()
    
    fileprivate lazy var writer: Writer = {
        let writer = Writer(dataStack: self.dataStack)
        return writer
    }()
}

extension AppController: UIApplicationDelegate {
    //MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { fatalError("Window not found") }
       
        if(!isAppAlreadyLaunchedOnce()){
            self.fetcher.fetchLocalData{ _ in }
        }

        UIApplication.shared.statusBarStyle = .lightContent
        window.rootViewController = TabBarController(fetcher: self.fetcher, writer:self.writer, dataStack: dataStack)
        window.makeKeyAndVisible()

        return true
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            return false
        }
    }
    
}

