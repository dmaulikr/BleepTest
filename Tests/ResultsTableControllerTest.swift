import XCTest
import DATAStack
import CoreData
@testable import BleepTest

class ResultsTableControllerTest: XCTestCase {
    
    private lazy var data: DATAStack = {
        let data = DATAStack(modelName: "iOS", bundle: NSBundle.mainBundle(), storeType:.InMemory)
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
        let user = NSEntityDescription.insertNewObjectForEntityForName("Player", inManagedObjectContext: data.mainContext)
        user.setValue(101, forKey: "age")
        user.setValue("Billy Jones", forKey: "username")
        try! self.data.mainContext.save()
        
        let request = NSFetchRequest(entityName: "Player")
        let objects = try! self.data.mainContext.executeFetchRequest(request)
        
        let writer = Writer(dataStack: self.data)
        writer.saveBleepTest(2, lap: 3, vo2Max: 20.3, distance: 50, player: objects[0] as? Player)
    }
    
}
