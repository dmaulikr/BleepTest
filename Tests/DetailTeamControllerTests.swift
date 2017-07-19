import XCTest
@testable import BleepTest

class DetailTeamControllerTests: XCTestCase {
    
    func test_HasDetailView() {
        let detailTeamViewController = DetailTeamController()
        _ = detailTeamViewController.view
        XCTAssertTrue(detailTeamViewController.view is DetailTeamView)
    }
    
}
