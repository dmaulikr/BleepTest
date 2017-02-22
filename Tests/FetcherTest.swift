import XCTest
import DATAStack
import CoreData
@testable import BleepTest

class FetcherTest: XCTestCase {
    
    func createDataStack(_ storeType: DATAStackStoreType = .inMemory) -> DATAStack {
        let dataStack = DATAStack(modelName: "iOS", bundle: Bundle.main, storeType:storeType)
        return dataStack
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchUsers() {
        let data = self.createDataStack()
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "Player", into: data.mainContext)
        user.setValue(101, forKey: "age")
        user.setValue("Billy Jones", forKey: "username")
        try! data.mainContext.save()
        
        let fetcher = Fetcher(dataStack: data)
        let players = fetcher.fetchUsers{_ in}

        XCTAssertEqual(players.count, 1)
    }
    
}
