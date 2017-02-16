import XCTest
@testable import BleepTest

class SpyBleepTestDelegate : BleepTestDelegate {
    
    
    func lapedUpDelegate(sender: BleepTest, lap: Int, distance: Int, vO2Max: Double) {
        
    }
    
    func newLevelDelegate(sender: BleepTest, numberOfLaps: Int, level: Int, lapTime: Double) {
        
    }
    
    func startedNewLap(sender: BleepTest, lap: Int, lapTime: Double) {
        
    }
    
    func bleepTestFinished(sender: BleepTest) {

    }
    
}
