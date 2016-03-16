
import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.italyRedColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
