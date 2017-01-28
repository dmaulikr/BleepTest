import XCTest
import DATAStack
import CoreData
@testable import BleepTest

class BleepTestTests: XCTestCase {
    
    func createDataStack(storeType: DATAStackStoreType = .InMemory) -> DATAStack {
        let dataStack = DATAStack(modelName: "iOS", bundle: NSBundle.mainBundle(), storeType:storeType)
        return dataStack
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBleepTest() {
        let data = self.createDataStack()
        
        data.performInNewBackgroundContext { backgroundContext in
            let entity = NSEntityDescription.entityForName("TestLevel", inManagedObjectContext: backgroundContext)!
            let object = NSManagedObject(entity: entity, insertIntoManagedObjectContext: backgroundContext)
            object.setValue("", forKey:  "id")
            object.setValue(1, forKey: "level")
            object.setValue(1, forKey: "laps")
            object.setValue(10.0, forKey: "lapTime")
            object.setValue(10.0, forKey: "speed")
            try! backgroundContext.save()
        }
        
        let request = NSFetchRequest(entityName: "TestLevel")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        let testLevels = (try! data.mainContext.executeFetchRequest(request) as! [TestLevel])

    }
    
}
