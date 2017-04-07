import XCTest
import Sync
import CoreData
@testable import BleepTest

class WriterTests: XCTestCase {
    
    func createDataStack(_ storeType: DataStackStoreType = .inMemory) -> DataStack {
        let dataStack = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:storeType)
        return dataStack
    }
    
    func fetchObjectsInContext(_ context: NSManagedObjectContext, entity: String) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let objects = try! context.fetch(request) as! [NSManagedObject]
        
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
        
            let objects = self.fetchObjectsInContext(data.mainContext, entity: "Player")
            XCTAssertEqual(objects.count, 1)
        

    }
    
    func testCreateCompletedTest(){
        let data = self.createDataStack()
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "Player", into: data.mainContext)
        user.setValue(101, forKey: "age")
        user.setValue("Billy Jones", forKey: "username")
        try! data.mainContext.save()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        var objects = try! data.mainContext.fetch(request)
        
        let writer = Writer(dataStack: data)
        writer.saveBleepTest(2, lap: 3, vo2Max: 20.3, distance: 50, player: objects[0] as? Player)
        
            objects = self.fetchObjectsInContext(data.mainContext, entity: "CompletedTest")
            XCTAssertEqual(objects.count, 1)
        
    }
}
