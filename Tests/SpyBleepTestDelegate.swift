import XCTest
@testable import BleepTest

class SpyBleepTestDelegate : BleepTestDelegate {
    
    var lapedUpDelegateResult: Bool? = .None
    var newLevelDelegateResult: Bool? = .None
    var startedNewLapResult: Bool? = .None
    var bleepTestFinishedResult: Bool? = .None

    var timerExpectation: XCTestExpectation?
    var newLevelExpectation: XCTestExpectation?
    var newLapExpectation: XCTestExpectation?
    var bleepTestFinishedExpectation: XCTestExpectation?

    func lapedUpDelegate(sender: BleepTest, lap: Int, distance: Int, vO2Max: Double) {
        guard timerExpectation != nil else {
            XCTFail("SpyBleepTestDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.lapedUpDelegateResult = true
    }
    
    func newLevelDelegate(sender: BleepTest, numberOfLaps: Int, level: Int, lapTime: Double) {
        guard newLevelExpectation != nil else {
            XCTFail("SpyBleepTestDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.newLevelDelegateResult = true
    }
    
    func startedNewLap(sender: BleepTest, lap: Int, lapTime: Double) {
        guard newLapExpectation != nil else {
            XCTFail("SpyBleepTestDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.startedNewLapResult = true
    }
    
    func bleepTestFinished(sender: BleepTest) {
        guard let expectation = bleepTestFinishedExpectation else {
            XCTFail("SpyBleepTestDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.bleepTestFinishedResult = true
        expectation.fulfill()
        newLapExpectation?.fulfill()
        newLevelExpectation?.fulfill()
        timerExpectation?.fulfill()
    }
    
}
