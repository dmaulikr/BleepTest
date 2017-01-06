import UIKit

class OrangeNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpNavigationBarAppearance() {
        navigationBar.barTintColor = UIColor.orangeColor()
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }

    func cancelButtonAction(sender: UIButton) {
        
    }
}
