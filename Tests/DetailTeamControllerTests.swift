import XCTest
import Sync
import CoreData
@testable import BleepTest

class DetailTeamControllerTests: XCTestCase {
    
    var detailTeamViewController: DetailTeamController!
    var dataStack: DataStack = DataStack()
    var entity: NSEntityDescription?
    var team: Team!

    override func setUp() {
        detailTeamViewController = DetailTeamController()
        _ = detailTeamViewController.view
        self.dataStack = self.createDataStack()
        self.entity = NSEntityDescription.entity(forEntityName: "Team", in: dataStack.mainContext)
        
        let teamManager = TeamManager()
        team = Team(name: "Test team", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext)
        teamManager.add(team)
        detailTeamViewController.team = teamManager.atIndex(0)
    }
    
    func createDataStack() -> DataStack {
        let dataStack = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
        return dataStack
    }
    
    func test_HasDetailView() {
        XCTAssertTrue(detailTeamViewController.view is DetailTeamView)        
    }
    
    func testSettingTeam_SetsTextToNameLabels() {
        detailTeamViewController.beginAppearanceTransition(true, animated: true)
        detailTeamViewController.endAppearanceTransition()
        
        XCTAssertNotNil(detailTeamViewController.rootView.titleLabel.text)
        XCTAssertEqual(detailTeamViewController.rootView.titleLabel.text!, team.name)
    }
    
}
