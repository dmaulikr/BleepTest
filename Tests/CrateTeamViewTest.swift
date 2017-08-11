import XCTest
@testable import BleepTest

class CrateTeamViewTest: XCTestCase {
    
    var createTeamView : CreateTeamView!

    override func setUp() {
        super.setUp()
        createTeamView = CreateTeamView(frame: CGRect(x:0,y:0, width:0, height:0))
    }
    
    func test_TitleLabel() {
        XCTAssertNotNil(createTeamView.titleLabel)
        XCTAssertTrue((createTeamView.titleLabel as Any) is MediumBlackLabel)
        XCTAssertEqual(createTeamView.titleLabel.text, "Create team")
    }

}
