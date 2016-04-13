import UIKit

@UIApplicationMain
class AppController: UIResponder {

    var window: UIWindow?
    var navController: UINavigationController?
    
    private lazy var fetcher: Fetcher = {
        let url = NSURL(string: "levelsData.json")!
        let fetcher = Fetcher(modelName: "iOS", localFilePath: url)
        return fetcher
    }()
    
    private lazy var writer: Writer = {
        let writer = Writer(modelName: "iOS")
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
        window.rootViewController = TabBarController(fetcher: self.fetcher, writer:self.writer)
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

