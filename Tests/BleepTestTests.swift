import XCTest
import DATAStack
import Sync
import CoreData
@testable import BleepTest

class BleepTestTests: XCTestCase {
    
    func createDataStack(storeType: DATAStackStoreType = .InMemory) -> DATAStack {
        let dataStack = DATAStack(modelName: "iOS", bundle: NSBundle.mainBundle(), storeType:storeType)
        return dataStack
    }
    
    func createLevels(data: DATAStack, completion: (NSError?) -> Void){
        let url = NSURL(string: "levelsData.json")!
        let filePath = NSBundle.mainBundle().pathForResource(url.URLByDeletingPathExtension?.absoluteString, ofType: url.pathExtension)!
        let jsonData = NSData(contentsOfFile: filePath)!
        let json = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! [String: AnyObject]
        Sync.changes(json["bleepTest"] as! Array, inEntityNamed: "TestLevel", predicate: nil, parent: nil, inContext: data.mainContext, dataStack: data, completion: { error in
            completion(error)
        })
        
    }
    
    func testSetDelgate(){
        let data = self.createDataStack()
        self.createLevels(data){ _ in }
        
        let request = NSFetchRequest(entityName: "TestLevel")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        let levels = (try! data.mainContext.executeFetchRequest(request) as! [TestLevel])
        
        let bleepTest = BleepTest(bleepTestLevels: levels)
        let spyBleepTestDelegate = SpyBleepTestDelegate()
        bleepTest.delegate = spyBleepTestDelegate
        
        XCTAssertTrue(bleepTest.delegate === spyBleepTestDelegate)
    }
    
    func testBleepTest() {
        let data = self.createDataStack()
        self.createLevels(data){ _ in }
        
        let request = NSFetchRequest(entityName: "TestLevel")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        let levels = (try! data.mainContext.executeFetchRequest(request) as! [TestLevel])
        
        let bleepTest = BleepTest(bleepTestLevels: levels)
        let spyBleepTestDelegate = SpyBleepTestDelegate()
        bleepTest.delegate = spyBleepTestDelegate
        
    }
    
}
