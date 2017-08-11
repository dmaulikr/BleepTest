import UIKit

class CreateTeamView: UIView {

    lazy var closeButton : CloseButton = {
        var temporyButton : CloseButton = CloseButton()
        return temporyButton
    }()
    
    lazy var titleLabel : MediumBlackLabel = {
        var temporyLabel : MediumBlackLabel = MediumBlackLabel()
        temporyLabel.text = "Create team"
        return temporyLabel
    }()
    
    lazy var nameTextField: YoshikoTextField = {
        let temporyTextField: YoshikoTextField = YoshikoTextField(frame: CGRect(x: 0, y: 0, width: 250, height: 55))
        temporyTextField.autocorrectionType = .no
        temporyTextField.returnKeyType = .next
        temporyTextField.placeholder = "Team Name  e.g. Office Football"
        temporyTextField.placeholderUpdated = "Team Name"
        return temporyTextField
    }()

    lazy var createButton : PinkRedOutlineButton = {
        var temporyButton : PinkRedOutlineButton = PinkRedOutlineButton()
        temporyButton.setTitle("Create", for: UIControlState())
        temporyButton.titleLabel!.font =  UIFont(name: temporyButton.titleLabel!.font.fontName, size: 18)
        return temporyButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
