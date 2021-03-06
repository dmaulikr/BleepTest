import UIKit

extension UIButton {
    class func menuButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "MenuButton"), for: UIControlState())
        button.frame = CGRect(x: 16, y: 4, width: 30, height: 30)
        return button
    }
}
