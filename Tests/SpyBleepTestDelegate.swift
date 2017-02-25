import XCTest
@testable import BleepTest

class SpyBleepTestDelegate : BleepTestDelegate {
    
    var lapedUpDelegateResult: Bool? = .none
    var newLevelDelegateResult: Bool? = .none
    var startedNewLapResult: Bool? = .none
    var bleepTestFinishedResult: Bool? = .none

    var timerExpectation: XCTestExpectation?
    var newLevelExpectation: XCTestExpectation?
    var newLapExpectation: XCTestExpectation?
    var bleepTestFinishedExpectation: XCTestExpectation?

    func lapedUpDelegate(_ sender: BleepTest, lap: Int, distance: Int, vO2Max: Double) {
        guard timerExpectation != nil else {
            XCTFail("SpyBleepTestDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.lapedUpDelegateResult = true
    }
    
    func newLevelDelegate(_ sender: BleepTest, numberOfLaps: Int, level: Int, lapTime: Double) {
        guard newLevelExpectation != nil else {
            XCTFail("SpyBleepTestDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.newLevelDelegateResult = true
    }
    
    func startedNewLap(_ sender: BleepTest, lap: Int, lapTime: Double) {
        guard newLapExpectation != nil else {
            XCTFail("SpyBleepTestDelegate was not setup correctly. Missing XCTExpectation reference")
            return
        }
        
        self.startedNewLapResult = true
    }
    
    func bleepTestFinished(_ sender: BleepTest) {
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
