import UIKit

class CreateSinglePlayerView: UIView {

    lazy var userNameTextField: YoshikoTextField = {
        let temporyTextField: YoshikoTextField = YoshikoTextField(frame: CGRect(x: 0, y: 0, width: 250, height: 55))
        temporyTextField.placeholder = "Username   e.g. John Smith"
        temporyTextField.placeholderUpdated = "Username"
        return temporyTextField
    }()
    
    lazy var ageTextField: YoshikoTextField = {
        let temporyTextField: YoshikoTextField = YoshikoTextField(frame: CGRect(x: 0, y: 0, width: 250, height: 55))
        temporyTextField.placeholder = "Age   e.g. 27"
        temporyTextField.placeholderUpdated = "Age"
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
            "ageTextField": ageTextField,
            "superview": self
        ]

        addSubview(userNameTextField)
        addSubview(ageTextField)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-100-[userNameTextField(55)]-30-[ageTextField(55)]-(>=20)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[userNameTextField(55)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[userNameTextField(250)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[ageTextField]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[ageTextField(250)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        
    }
    
}
