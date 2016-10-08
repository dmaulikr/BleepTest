import UIKit

class CreateSinglePlayerView: UIView {
    
    lazy var closeButton : CloseButton = {
        var tempryLabel : CloseButton = CloseButton()
        return tempryLabel
    }()
    
    lazy var titleLabel : MediumBlackLabel = {
        var temporyLabel : MediumBlackLabel = MediumBlackLabel()
        temporyLabel.text = "Create user"
        return temporyLabel
    }()

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
        temporyTextField.keyboardType = UIKeyboardType.NumberPad
        return temporyTextField
    }()
    
    lazy var createButton : PinkRedOutlineButton = {
        var temporyButton : PinkRedOutlineButton = PinkRedOutlineButton()
        temporyButton.setTitle("Create", forState: UIControlState.Normal)
        temporyButton.addTarget(self, action: #selector(createButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        temporyButton.titleLabel!.font =  UIFont(name: temporyButton.titleLabel!.font.fontName, size: 18)
        return temporyButton
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
            "closeButton": closeButton,
            "userNameTextField": userNameTextField,
            "ageTextField": ageTextField,
            "createButton": createButton,
            "titleLabel": titleLabel,
            "superview": self
        ]

        addSubview(userNameTextField)
        addSubview(ageTextField)
        addSubview(createButton)
        addSubview(titleLabel)
        addSubview(closeButton)
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-15-[closeButton(20)]-(>=20)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-15-[closeButton(20)]-(>=20)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-50-[titleLabel]-40-[userNameTextField(55)]-15-[ageTextField(55)]-90-[createButton(40)]-(>=20)-|",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[titleLabel]",
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
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[superview]-(<=1)-[createButton]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:[createButton(100)]",
            options: NSLayoutFormatOptions.AlignAllCenterX,
            metrics: nil,
            views: viewsDictionary))
    }
}

//MARK: Action
extension CreateSinglePlayerView{
    func createButtonAction(sender:UIButton){
        
    }
}
