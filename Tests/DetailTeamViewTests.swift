import XCTest
@testable import BleepTest

class DetailTeamViewTests: XCTestCase {
    
    let detailTeamView = DetailTeamView()
    
    func test_HasTitleLabel() {
        XCTAssertNotNil(detailTeamView.titleLabel)
    }
    
}
