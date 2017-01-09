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
    
    func testCreateCompletedTest(){
        let data = self.createDataStack()
        
        let user = NSEntityDescription.insertNewObjectForEntityForName("Player", inManagedObjectContext: data.mainContext)
        user.setValue(101, forKey: "age")
        user.setValue("Billy Jones", forKey: "username")
        try! data.mainContext.save()
        
        let request = NSFetchRequest(entityName: "Player")
        let objects = try! data.mainContext.executeFetchRequest(request)
        
        let writer = Writer(dataStack: data)
        writer.saveBleepTest(2, lap: 3, vo2Max: 20.3, distance: 50, player: objects[0] as? Player)
        
        data.persistWithCompletion({
            let objects = self.fetchObjectsInContext(data.mainContext, entity: "CompletedTest")
            XCTAssertEqual(objects.count, 1)
        })
        
    }
}
