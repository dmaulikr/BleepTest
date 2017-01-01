import XCTest
import DATAStack
import CoreData
@testable import BleepTest

class WriterTests: XCTestCase {
    
    func createDataStack(storeType: DATAStackStoreType = .InMemory) -> DATAStack {
        let dataStack = DATAStack(modelName: "iOS", bundle: NSBundle.mainBundle(), storeType:storeType)
        return dataStack
    }
    
    func fetchObjectsInContext(context: NSManagedObjectContext, entity: String) -> [NSManagedObject] {
        let request = NSFetchRequest(entityName: entity)
        let objects = try! context.executeFetchRequest(request) as! [NSManagedObject]
        
        return objects
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreatePlayer(){
        let data = self.createDataStack()
        
        let writer = Writer(dataStack: data)
        writer.createPlayer("John Gwyn", age: 10)
        
        data.persistWithCompletion({
            let objects = self.fetchObjectsInContext(data.mainContext, entity: "Player")
            XCTAssertEqual(objects.count, 1)
        })

    }
    
}
