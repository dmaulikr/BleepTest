import XCTest
@testable import BleepTest

class CreateTeamViewTest: XCTestCase {
    
    var createTeamView : CreateTeamView!

    override func setUp() {
        super.setUp()
        createTeamView = CreateTeamView(frame: CGRect(x:0,y:0, width:0, height:0))
    }
    
    func test_ViewBackground_IsWhiteColour() {
        XCTAssertEqual(createTeamView.backgroundColor, .white)
    }
    
    func test_titleLabel() {
        XCTAssertNotNil(createTeamView.titleLabel)
        XCTAssertTrue((createTeamView.titleLabel as Any) is MediumBlackLabel)
        XCTAssertEqual(createTeamView.titleLabel.text, "Create team")
    }
    
    func test_closeButton() {
        XCTAssertNotNil(createTeamView.closeButton)
        XCTAssertTrue((createTeamView.closeButton as Any) is CloseButton)
    }
    
    func test_closeButton_runActionMethodWhenClicked() {
        let mockCreateTeamView = MockCreateTeamView()
        mockCreateTeamView.closeButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockCreateTeamView.closeButtonActionCalled)
    }
    
    func test_closeButton_delegateCalledWhenClicked() {
        let spyCreateTeamViewDelegate = SpyCreateTeamViewDelegate()
        createTeamView.delegate = spyCreateTeamViewDelegate
        createTeamView.closeButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(spyCreateTeamViewDelegate.didCloseButtonPressed)
    }
    
    func test_nameTextField() {
        XCTAssertNotNil(createTeamView.nameTextField)
        XCTAssertTrue((createTeamView.nameTextField as Any) is YoshikoTextField)
        XCTAssertEqual(createTeamView.nameTextField.placeholder, "Team Name  e.g. Office Football")
        XCTAssertEqual(createTeamView.nameTextField.placeholderUpdated, "Team Name")
        XCTAssertEqual(createTeamView.nameTextField.returnKeyType, UIReturnKeyType.next)
        XCTAssertEqual(createTeamView.nameTextField.autocorrectionType, UITextAutocorrectionType.no)
    }
    
    func test_descriptionTextField() {
        XCTAssertNotNil(createTeamView.descriptionTextField)
        XCTAssertTrue((createTeamView.descriptionTextField as Any) is YoshikoTextField)
        XCTAssertEqual(createTeamView.descriptionTextField.placeholder, "Team description...")
        XCTAssertEqual(createTeamView.descriptionTextField.placeholderUpdated, "Description")
        XCTAssertEqual(createTeamView.descriptionTextField.returnKeyType, UIReturnKeyType.next)
        XCTAssertEqual(createTeamView.descriptionTextField.autocorrectionType, UITextAutocorrectionType.no)
    }
    
    func test_createButton() {
        XCTAssertNotNil(createTeamView.createButton)
        XCTAssertTrue((createTeamView.createButton as Any) is PinkRedOutlineButton)
        XCTAssertEqual(createTeamView.createButton.titleLabel?.text, "Create")
        XCTAssertEqual(createTeamView.createButton.titleLabel?.font, UIFont(name: createTeamView.createButton.titleLabel!.font.fontName, size: 18))
    }
    
    func test_createButton_runActionMethodWhenClicked() {
        let mockCreateTeamView = MockCreateTeamView()
        mockCreateTeamView.createButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockCreateTeamView.createButtonActionCalled)
    }
    
    func test_createButton_delegateCalledWhenClicked() {
        let spyCreateTeamViewDelegate = SpyCreateTeamViewDelegate()
        createTeamView.delegate = spyCreateTeamViewDelegate
        createTeamView.nameTextField.text = "Footy"
        createTeamView.descriptionTextField.text = "The team description"
        createTeamView.createButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(spyCreateTeamViewDelegate.didCreateButtonPressed)
        XCTAssertEqual(spyCreateTeamViewDelegate.name, "Footy")
        XCTAssertEqual(spyCreateTeamViewDelegate.teamDescription, "The team description")
    }
}

extension CreateTeamViewTest {
    
    class MockCreateTeamView: CreateTeamView {
        var createButtonActionCalled = false
        var closeButtonActionCalled = false

        override func closeButtonAction(_ sender:UIButton){
            closeButtonActionCalled = true
        }
        
        override func createButtonAction(_ sender:UIButton){
            createButtonActionCalled = true
        }
    }
    
    class SpyCreateTeamViewDelegate: CreateTeamViewDelegate {
        var didCloseButtonPressed = false
        var didCreateButtonPressed = false
        var name = ""
        var teamDescription = ""

        func didCloseButtonPressed(_ sender: CreateTeamView) {
            didCloseButtonPressed = true
        }
        
        func didCreateButtonPressed(_ sender: CreateTeamView, name:String, description:String) {
            didCreateButtonPressed = true
            self.name = name
            self.teamDescription = description
        }
    }
}
