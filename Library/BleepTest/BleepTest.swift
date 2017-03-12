import Foundation
import SwiftyTimer
import AVFoundation

protocol BleepTestDelegate: class {
    func lapedUpDelegate(_ sender: BleepTest, lap: Int, distance: Int, vO2Max: Double) 
    func newLevelDelegate(_ sender: BleepTest, numberOfLaps: Int, level: Int, lapTime: Double, distance: Int)
    func startedNewLap(_ sender: BleepTest, lap: Int, lapTime: Double)
    func bleepTestFinished(_ sender: BleepTest)
}

class BleepTest {
    
    weak var delegate:BleepTestDelegate?
    fileprivate var levels : [TestLevel]!
    fileprivate var testLevel : TestLevel!
    fileprivate var level : Int!
    fileprivate var lap : Int!
    fileprivate var timer : Timer!
    fileprivate var beepSoundEffect : AVAudioPlayer!
    fileprivate var distance : Int!
    fileprivate var vO2Max : Double!

    init(bleepTestLevels: [TestLevel]) {
        self.levels = bleepTestLevels
    }
}

// MARK: Bleep Test Logic
extension BleepTest{
    func start() {
        level = 0
        distance = 0
        timer = Timer.after(0.5.seconds){
            self.levelRun(self.level!)
        }
        timer.start()
    }
    
    func stop() {
        timer.invalidate()
        timer = Timer.after(10.seconds){
            UIApplication.shared.isIdleTimerDisabled = false
            self.timer.invalidate()
        }
        timer.start()
    }
    
    fileprivate func levelRun(_ i : Int){
        if (i != levels.count){
            testLevel = levels[i]
            lap = 0
            vO2Max = 3.46 * (Double(testLevel.level)+Double(lap+1) / ((Double(testLevel.level) * 0.4325 + 7.0048))) + 12.2
            delegate?.newLevelDelegate(self, numberOfLaps: Int(testLevel.laps), level: Int(testLevel.level), lapTime: testLevel.lapTime, distance: Int(distance))
            delegate?.lapedUpDelegate(self, lap: Int(lap + 1), distance: Int(distance), vO2Max: vO2Max)
            runLap()
        } else{
            beep()
            delegate?.bleepTestFinished(self)
        }
    }
    
    fileprivate func runLap(){
        if(Int(testLevel.laps) == lap){
            level = level + 1
            levelRun(level)
        } else {
            beep()
            runningLap()
        }
    }
    
    fileprivate func runningLap(){
        let lapTime = Double(testLevel.lapTime)
        delegate?.startedNewLap(self, lap: lap, lapTime: lapTime)
        timer = Timer.after(lapTime.seconds){
            self.lapFinished()
        }
        timer.start()
    }
    
    fileprivate func beep(){
        let sound =  URL(fileURLWithPath: Bundle.main.path(forResource: "beep", ofType: "wav")!)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        try! beepSoundEffect = AVAudioPlayer(contentsOf: sound)
        try! session.setCategory(AVAudioSessionCategoryPlayback)
        try! session.setActive(true)
        beepSoundEffect.prepareToPlay()
        beepSoundEffect.play()
    }
    
    fileprivate func lapFinished(){
        lap = lap + 1
        distance = distance + 20
        vO2Max = 3.46 * (Double(testLevel.level)+Double(lap+1) / ((Double(testLevel.level) * 0.4325 + 7.0048))) + 12.2
        delegate?.lapedUpDelegate(self, lap: Int(lap + 1), distance: Int(distance), vO2Max: vO2Max)
        runLap()
    }
}
