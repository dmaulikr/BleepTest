import UIKit

class StartButton: UIButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.italyGreenColor().setFill()
        path.fill()
    }
}
