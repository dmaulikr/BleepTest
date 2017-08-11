import XCTest
import Sync
import CoreData
@testable import BleepTest

class TeamListControllerTest: XCTestCase {
    
    var teamListContorller: TeamListController!
    
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
        teamListContorller = TeamListController(fetcher: self.fetcher, writer: self.writer, dataStack: self.data)
        _ = teamListContorller.view
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(teamListContorller.tableView)
    }
    
    func test_TitleName() {
        XCTAssertEqual(teamListContorller.title, "Teams")
    }
    
    func testVeiwDidLoad_ShouldSetTableDataSource() {
        XCTAssertNotNil(teamListContorller.tableView.dataSource)
        XCTAssertTrue(teamListContorller.tableView.dataSource is TeamDataProvider)
    }
    
    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(teamListContorller.tableView.delegate)
        XCTAssertTrue(teamListContorller.tableView.delegate is TeamDataProvider)
    }
    
    func testViewDidLoad_ShouldSetDelegateAndDataSourceToTheSameObject() {
        XCTAssertEqual(teamListContorller.tableView.delegate as? TeamDataProvider, teamListContorller.tableView.dataSource as? TeamDataProvider)
    }
    
    func testRightBarButton_IsNotNill() {
        XCTAssertNotNil(teamListContorller.navigationItem.rightBarButtonItem)
    }
    
    func testRightBarButton_Title() {
        XCTAssertEqual(teamListContorller.navigationItem.rightBarButtonItem?.title, "+")
    }
    
    func testRightBarButton_Action() {
        let mockTeamListController = MockTeamListController(fetcher: self.fetcher, writer: self.writer, dataStack: self.data)
        _ = mockTeamListController.view
        
        let barButtonItem = mockTeamListController.navigationItem.rightBarButtonItem
        let button: UIButton = UIButton()
        button.sendAction((barButtonItem?.action)!, to: barButtonItem?.target, for: nil)
        
        XCTAssertTrue(mockTeamListController.rightBarButtonCalled)
    }
    
    func test_PresentCreateTeamController_WhenRightBarButtonPressed() {
        let mockNavigationController = MockNavigationController()
        mockNavigationController.setViewControllers([teamListContorller], animated: false)
        
        let barButtonItem = teamListContorller.navigationItem.rightBarButtonItem
        let button: UIButton = UIButton()
        button.sendAction((barButtonItem?.action)!, to: barButtonItem?.target, for: nil)
        
        XCTAssertEqual(mockNavigationController.prestentVeiwControllerIsCalled, true)
    }
    
}

extension TeamListControllerTest {
    
    class MockTeamListController: TeamListController {
       var rightBarButtonCalled = false
        
        override func createTeamButtonAction(_ sender: UIButton!) {
            rightBarButtonCalled = true
        }
    }
    
    class MockNavigationController: UINavigationController {
        var prestentVeiwControllerIsCalled = false
        
        override internal func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
            prestentVeiwControllerIsCalled = true
        }
    }
}

