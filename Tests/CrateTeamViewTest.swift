import XCTest
@testable import BleepTest

class CrateTeamViewTest: XCTestCase {
    
    var createTeamView : CreateTeamView!

    override func setUp() {
        super.setUp()
        createTeamView = CreateTeamView(frame: CGRect(x:0,y:0, width:0, height:0))
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
    
    func test_nameTextField() {
        XCTAssertNotNil(createTeamView.nameTextField)
        XCTAssertTrue((createTeamView.nameTextField as Any) is YoshikoTextField)
        XCTAssertEqual(createTeamView.nameTextField.placeholder, "Team Name  e.g. Office Football")
        XCTAssertEqual(createTeamView.nameTextField.placeholderUpdated, "Team Name")
        XCTAssertEqual(createTeamView.nameTextField.returnKeyType, UIReturnKeyType.next)
        XCTAssertEqual(createTeamView.nameTextField.autocorrectionType, UITextAutocorrectionType.no)
    }

}
