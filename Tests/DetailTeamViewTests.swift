import XCTest
import Sync
import CoreData
@testable import BleepTest

class DetailTeamViewTests: XCTestCase {
    
    var detailTeamView: DetailTeamView!
    var dataStack: DataStack = DataStack()
    var entity: NSEntityDescription?
    var team: Team!
    
    override func setUp() {
        super.setUp()
        self.dataStack = self.createDataStack()
        self.entity = NSEntityDescription.entity(forEntityName: "Team", in: dataStack.mainContext)
        team = Team(name: "Test name", teamDescription: "Team description", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext)
        detailTeamView = DetailTeamView(frame: CGRect(x:0,y:0, width:0, height:0), team)
    }
    
    func createDataStack() -> DataStack {
        let dataStack = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
        return dataStack
    }
    
    func test_HasTitleLabel() {
        XCTAssertNotNil(detailTeamView.titleLabel)
    }
    
    func test_HasDescriptionLabel() {
        XCTAssertNotNil(detailTeamView.descriptionLabel)
    }
    
    func test_loadViewMethod() {
        XCTAssertNotNil(detailTeamView.titleLabel.text)
        XCTAssertEqual(detailTeamView.titleLabel.text!, team.name)
        XCTAssertNotNil(detailTeamView.descriptionLabel.text)
        XCTAssertEqual(detailTeamView.descriptionLabel.text!, team.teamDescription)
    }
    
}
