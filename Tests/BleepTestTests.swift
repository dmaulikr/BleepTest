import XCTest
import DATAStack
import Sync
import CoreData
@testable import BleepTest

class BleepTestTests: XCTestCase {
    
    func createDataStack(_ storeType: DATAStackStoreType = .InMemory) -> DATAStack {
        let dataStack = DATAStack(modelName: "iOS", bundle: Bundle.main, storeType:storeType)
        return dataStack
    }
    
    func createLevels(_ data: DATAStack, completion: @escaping (NSError?) -> Void){
        let filePath = Bundle.main.path(forResource: "testLevelsData", ofType: "json")!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
        
        Sync.changes(json["bleepTest"] as! Array, inEntityNamed: "TestLevel", predicate: nil, parent: nil, inContext: data.mainContext, dataStack: data, completion: { error in
            completion(error)
        })
    }
    
    func testSetDelgate(){
        let data = self.createDataStack()
        self.createLevels(data){ _ in }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TestLevel")
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
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TestLevel")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        let levels = (try! data.mainContext.executeFetchRequest(request) as! [TestLevel])
        
        let bleepTest = BleepTest(bleepTestLevels: levels)
        let spyBleepTestDelegate = SpyBleepTestDelegate()
        bleepTest.delegate = spyBleepTestDelegate
        
        weak var lapedUpExpectation = expectation(description: "BleepTest calls a delegate as the result of an laped up method completion")
        spyBleepTestDelegate.timerExpectation = lapedUpExpectation
        
        weak var newLevelExpection = expectation(description: "BleepTest calls a delegate as the result of an other up method completion")
        spyBleepTestDelegate.newLevelExpectation = newLevelExpection
        
        weak var newLapExpection = expectation(description: "BleepTest calls a delegate as the result of an other up method completion")
        spyBleepTestDelegate.newLapExpectation = newLapExpection
        
        weak var bleepTestFinishedExpectation = expectation(description: "BleepTest calls a delegate as the result of an other up method completion")
        spyBleepTestDelegate.bleepTestFinishedExpectation = bleepTestFinishedExpectation
        
        bleepTest.start()
        
        waitForExpectations(timeout: 100) { error in
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
