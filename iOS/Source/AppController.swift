import UIKit
import DATAStack

@UIApplicationMain
class AppController: UIResponder {

    var window: UIWindow?
    var navController: UINavigationController?
    
    private lazy var dataStack: DATAStack = {
        let data = DATAStack(modelName: "iOS", bundle: NSBundle.mainBundle(), storeType:.SQLite)
        return data
    }()
    
    private lazy var fetcher: Fetcher = {
        let fetcher = Fetcher(dataStack: self.dataStack)
        return fetcher
    }()
    
    private lazy var writer: Writer = {
        let writer = Writer(dataStack: self.dataStack)
        return writer
    }()
}

extension AppController: UIApplicationDelegate {
    //MARK: UIApplicationDelegate
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        guard let window = self.window else { fatalError("Window not found") }
       
        if(!isAppAlreadyLaunchedOnce()){
            self.fetcher.fetchLocalData{ _ in }
        }

        UIApplication.sharedApplication().statusBarStyle = .LightContent
        window.rootViewController = TabBarController(fetcher: self.fetcher, writer:self.writer, dataStack: dataStack)
        window.makeKeyAndVisible()

        return true
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        if let _ = defaults.stringForKey("isAppAlreadyLaunchedOnce"){
            return true
        }else{
            defaults.setBool(true, forKey: "isAppAlreadyLaunchedOnce")
            return false
        }
    }
    
}

