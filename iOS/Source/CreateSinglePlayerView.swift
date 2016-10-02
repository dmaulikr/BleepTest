import UIKit

class CreateSinglePlayerView: UIView {

    lazy var userNameTextField: YoshikoTextField = {
        let temporyTextField: YoshikoTextField = YoshikoTextField(frame: CGRect(x: 0, y: 0, width: 250, height: 55))
        temporyTextField.placeholder = "Username"
        return temporyTextField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
        backgroundColor = .whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createView(){
        let viewsDictionary = [
            "userNameTextField": userNameTextField,
            "superview": self
        ]

        addSubview(userNameTextField)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-50-[userNameTextField(55)]-(>=20)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[userNameTextField]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[userNameTextField(250)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        
    }
    
}
