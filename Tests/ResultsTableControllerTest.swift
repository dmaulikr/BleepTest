import XCTest
import DATAStack
import CoreData
@testable import BleepTest

class ResultsTableControllerTest: XCTestCase {
    
    private lazy var data: DATAStack = {
        let data = DATAStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
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
    
    override func setUp(){
        let user = NSEntityDescription.insertNewObject(forEntityName: "Player", into: data.mainContext)
        user.setValue(101, forKey: "age")
        user.setValue("Billy Jones", forKey: "username")
        try! self.data.mainContext.save()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        let objects = try! self.data.mainContext.fetch(request)
        
        let writer = Writer(dataStack: self.data)
        writer.saveBleepTest(2, lap: 3, vo2Max: 20.3, distance: 50, player: objects[0] as? Player)
    }

    func testTableViewControllerTable(){
        let resultsController = ResultsTableController(fetcher: self.fetcher, writer: self.writer, dataStack: self.data)
        let countedRows = resultsController.tableView.numberOfRows(inSection: 0)
        
        let fetchedReslults = fetcher.fetchCompletedTest{_ in}
        
        XCTAssert(countedRows == fetchedReslults.count)
    }
    
    func testResultsTableCells() {
        let resultsController = ResultsTableController(fetcher: self.fetcher, writer: self.writer, dataStack: self.data)
        let resultsCell :ResultsCell = resultsController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ResultsCell
        
        XCTAssertEqual(resultsCell.levelLabel.text!, "2")
        XCTAssertEqual(resultsCell.lapLabel.text!, "3")
        XCTAssertEqual(resultsCell.playerNameLabel.text!, "Billy Jones")
        XCTAssertEqual(resultsCell.vo2MaxLabel.text!, "20.3")
        XCTAssertEqual(resultsCell.distanceLabel.text!, "50")
    }
    
}
