import XCTest
@testable import BleepTest

class DetailTeamViewTests: XCTestCase {
    
    let detailTeamView = DetailTeamView()
    
    func test_HasTitleLabel() {
        XCTAssertNotNil(detailTeamView.titleLabel)
    }
    
    func test_hasTabelView() {
        XCTAssertNotNil(detailTeamView.playerTabel)
    }
    
}
