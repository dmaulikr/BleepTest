import XCTest
import Sync
import CoreData
@testable import BleepTest

class CreateTeamControllerTest: XCTestCase {
    
    var createTeamController: CreateTeamController!
    
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
}

extension CreateTeamControllerTest {
    
    class MockNavigationController: UINavigationController {
        
        var dismissControllerIsCalled = false

        override internal func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            dismissControllerIsCalled = true
        }
    }
}
