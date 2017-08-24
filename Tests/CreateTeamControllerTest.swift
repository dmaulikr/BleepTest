import XCTest
import Sync
import CoreData
@testable import BleepTest

class CreateTeamControllerTest: XCTestCase {
    
    private var createTeamController: CreateTeamController!
    
    private lazy var data: DataStack = {
        let data = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
        return data
    }()
    
    private lazy var fetcher: Fetcher = {
        let fetcher = Fetcher(dataStack: self.data)
        return fetcher
    }()
    
    private lazy var writer: Writer = {
        let writer = Writer(dataStack: self.data)
        return writer
    }()
    
    func fetchObjectsInContext(_ context: NSManagedObjectContext, entity: String) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let objects = try! context.fetch(request) as! [NSManagedObject]
        
        return objects
    }
    
    override func setUp() {
        createTeamController = CreateTeamController(fetcher: self.fetcher, writer: self.writer, dataStack: self.data)
        _ = createTeamController.view
    }
    
    func testController() {
        XCTAssertNotNil(createTeamController)
    }
    
    func test_HasView() {
        XCTAssertTrue(createTeamController.view is CreateTeamView)
    }
    
    func test_HasViewDelegates() {
        XCTAssertTrue(createTeamController.responds(to: #selector(CreateTeamController.didCloseButtonPressed(_:))))
        XCTAssertTrue(createTeamController.responds(to: #selector(CreateTeamController.didCreateButtonPressed(_:name:description:))))
    }
    
    func test_CloseButtonPressedDeleget_DismissController() {
        let rootViewController = UIViewController()
        let mockNavigationController = MockNavigationController(rootViewController: rootViewController)
       
        mockNavigationController.viewControllers = [rootViewController, createTeamController]
        createTeamController.didCloseButtonPressed(createTeamController.view as! CreateTeamView)

        XCTAssertTrue(mockNavigationController.dismissControllerIsCalled)
    }
    
    func test_CreateButtonPressedDeleget_DismissController() {
        let rootViewController = UIViewController()
        let mockNavigationController = MockNavigationController(rootViewController: rootViewController)
        
        mockNavigationController.viewControllers = [rootViewController, createTeamController]
        createTeamController.didCreateButtonPressed(createTeamController.view as! CreateTeamView, name: "Bob", description: "")
        
        XCTAssertTrue(mockNavigationController.dismissControllerIsCalled)
    }
    
    func test_CreateButtonPressedDeleget_SaveTeam() {
        createTeamController.didCreateButtonPressed(createTeamController.view as! CreateTeamView, name: "Test name", description: "Description")
        
        let savedTeams = self.fetchObjectsInContext(self.data.mainContext, entity: "Team")
        let team = savedTeams[0] as! Team
        
        XCTAssertEqual(team.name, "Test name")
    }
}

extension CreateTeamControllerTest {
    
    class MockNavigationController: UINavigationController {
        
        var dismissControllerIsCalled = false

        override internal func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            dismissControllerIsCalled = true
        }
    }
}
