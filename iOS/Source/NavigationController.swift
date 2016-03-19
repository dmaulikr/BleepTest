
import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .customBlueColor()
        navigationBar.tintColor = .whiteColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = .LightContent
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
