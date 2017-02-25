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
        navigationBar.barTintColor = UIColor.orange
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }

    func cancelButtonAction(_ sender: UIButton) {
        
    }
}
