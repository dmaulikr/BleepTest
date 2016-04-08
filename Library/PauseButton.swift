import UIKit

class PauseButton: UIButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.customBlueColor().setFill()
        path.fill()
    }
}
