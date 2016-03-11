import UIKit

@UIApplicationMain
class AppController: UIResponder {

    var window: UIWindow?

    private lazy var fetcher: Fetcher = {

        let url = NSURL(string: "levelsData.json")!
        let fetcher = Fetcher(baseURL: "https://server.com", modelName: "iOS", localFilePath: url)

        return fetcher
    }()
    
}

extension AppController: UIApplicationDelegate {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        guard let window = self.window else { fatalError("Window not found") }
       
        if(!isAppAlreadyLaunchedOnce()){
            self.fetcher.fetchLocalData{ _ in }
        }
        
        window.rootViewController = BleepTestController(fetcher: self.fetcher)
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

