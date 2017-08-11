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
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
