import XCTest
import DATAStack
import CoreData
@testable import BleepTest

class PlayerTest: XCTestCase {
    
    func createDataStack() -> DATAStack {
        let dataStack = DATAStack(modelName: "iOS", bundle: Bundle.mainBundle, storeType:.InMemory)
        return dataStack
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPlayerInCoreData(){
        let dataStack = self.createDataStack()

        let user = NSEntityDescription.insertNewObject(forEntityName: "Player", into: dataStack.mainContext)
        user.setValue(101, forKey: "age")
        user.setValue("Billy Jones", forKey: "username")
        try! dataStack.mainContext.save()
       
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        let objects = try! dataStack.mainContext.fetch(request)
        XCTAssertEqual(objects.count, 1)
    }
    
}
