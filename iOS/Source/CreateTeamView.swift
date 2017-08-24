import UIKit

protocol CreateTeamViewDelegate: class {
    func didCloseButtonPressed(_ sender: CreateTeamView)
    func didCreateButtonPressed(_ sender: CreateTeamView, name:String, description:String)
}

class CreateTeamView: UIView {
    
    weak var delegate:CreateTeamViewDelegate?

    lazy var closeButton : CloseButton = {
        var temporyButton : CloseButton = CloseButton()
        temporyButton.addTarget(self, action: #selector(closeButtonAction(_:)), for: UIControlEvents.touchUpInside)
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
    
    lazy var descriptionTextField: YoshikoTextField = {
        let temporyTextField: YoshikoTextField = YoshikoTextField(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        temporyTextField.autocorrectionType = .no
        temporyTextField.returnKeyType = .next
        temporyTextField.placeholder = "Team description..."
        temporyTextField.placeholderUpdated = "Description"
        return temporyTextField
    }()

    lazy var createButton : PinkRedOutlineButton = {
        var temporyButton : PinkRedOutlineButton = PinkRedOutlineButton()
        temporyButton.setTitle("Create", for: UIControlState())
        temporyButton.titleLabel!.font =  UIFont(name: temporyButton.titleLabel!.font.fontName, size: 18)
        temporyButton.addTarget(self, action: #selector(createButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return temporyButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//Mark:Action
extension CreateTeamView {
    func closeButtonAction(_ sender:UIButton){
        delegate?.didCloseButtonPressed(self)
    }
    
    func createButtonAction(_ sender:UIButton){
        delegate?.didCreateButtonPressed(self, name: nameTextField.text!, description: description)
    }
}
