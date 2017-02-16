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
    
    func testBleepTestDelegates() {
        let data = self.createDataStack()
        self.createLevels(data){ _ in }
        
        let request = NSFetchRequest(entityName: "TestLevel")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        let levels = (try! data.mainContext.executeFetchRequest(request) as! [TestLevel])
        
        let bleepTest = BleepTest(bleepTestLevels: levels)
        let spyBleepTestDelegate = SpyBleepTestDelegate()
        bleepTest.delegate = spyBleepTestDelegate
        
        weak var lapedUpExpectation = expectationWithDescription("BleepTest calls a delegate as the result of an laped up method completion")
        spyBleepTestDelegate.timerExpectation = lapedUpExpectation
        
        weak var newLevelExpection = expectationWithDescription("BleepTest calls a delegate as the result of an other up method completion")
        spyBleepTestDelegate.newLevelExpectation = newLevelExpection
        
        weak var newLapExpection = expectationWithDescription("BleepTest calls a delegate as the result of an other up method completion")
        spyBleepTestDelegate.newLapExpectation = newLapExpection
        
        weak var bleepTestFinishedExpectation = expectationWithDescription("BleepTest calls a delegate as the result of an other up method completion")
        spyBleepTestDelegate.bleepTestFinishedExpectation = bleepTestFinishedExpectation
        
        bleepTest.start()
        
        waitForExpectationsWithTimeout(100) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            guard let resultLapedUp = spyBleepTestDelegate.lapedUpDelegateResult else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(resultLapedUp)
            
            guard let newLevelResult = spyBleepTestDelegate.newLevelDelegateResult else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(newLevelResult)
            
            guard let newLapResult = spyBleepTestDelegate.startedNewLapResult else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(newLapResult)
            
            guard let bleepTestFinishedResult = spyBleepTestDelegate.bleepTestFinishedResult else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(bleepTestFinishedResult)
        }
        
    }
    
}
