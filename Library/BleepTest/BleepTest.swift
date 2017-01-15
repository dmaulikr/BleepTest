import Foundation
import SwiftyTimer
import AVFoundation

protocol BleepTestDelegate: class {
    func lapedUpDelegate(sender: BleepTest, lap: Int, distance: Int, vO2Max: Double) 
    func newLevelDelegate(sender: BleepTest, numberOfLaps: Int, level: Int, lapTime: Double)
    func startedNewLap(sender: BleepTest, lapTime: Double)
    func bleepTestFinished(sender: BleepTest)
}

class BleepTest: NSObject {
    
    weak var delegate:BleepTestDelegate?
    private var levels : [TestLevel]!
    private var testLevel : TestLevel!
    private var level : Int!
    private var lap : Int!
    private var timer : NSTimer!
    private var beepSoundEffect : AVAudioPlayer!
    private var distance : Int!
    private var vO2Max : Double!

    init(bleepTestLevels: [TestLevel]) {
        super.init()
        self.levels = bleepTestLevels
    }
}

// MARK: Bleep Test Logic
extension BleepTest{
    func start() {
        level = 0
        distance = 0
        timer = NSTimer.after(0.5.seconds){
            self.levelRun(self.level!)
        }
        timer.start()
    }
    
    func stop() {
        timer.invalidate()
        timer = NSTimer.after(10.seconds){
            UIApplication.sharedApplication().idleTimerDisabled = false
            self.timer.invalidate()
        }
        timer.start()
    }
    
    private func levelRun(i : Int){
        if (i != levels.count){
            testLevel = levels[i]
            lap = 0
            vO2Max = 3.46 * (Double(testLevel.level)+Double(lap+1) / ((Double(testLevel.level) * 0.4325 + 7.0048))) + 12.2
            delegate?.newLevelDelegate(self, numberOfLaps: Int(testLevel.laps), level: Int(testLevel.level), lapTime: testLevel.lapTime)
            delegate?.lapedUpDelegate(self, lap: Int(lap + 1), distance: Int(distance), vO2Max: vO2Max)
            runLap()
        } else{
            beep()
            delegate?.bleepTestFinished(self)
        }
    }
    
    private func runLap(){
        if(Int(testLevel.laps) == lap){
            level = level + 1
            levelRun(level)
        } else {
            beep()
            runningLap()
        }
    }
    
    private func runningLap(){
        let lapTime = Double(testLevel.lapTime)
        delegate?.startedNewLap(self, lapTime: lapTime)
        timer = NSTimer.after(lapTime.seconds){
            self.lapFinished()
        }
        timer.start()
    }
    
    private func beep(){
        let sound =  NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beep", ofType: "wav")!)
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        try! beepSoundEffect = AVAudioPlayer(contentsOfURL: sound)
        try! session.setCategory(AVAudioSessionCategoryPlayback)
        try! session.setActive(true)
        beepSoundEffect.prepareToPlay()
        beepSoundEffect.play()
    }
    
    private func lapFinished(){
        lap = lap + 1
        distance = distance + 20
        vO2Max = 3.46 * (Double(testLevel.level)+Double(lap+1) / ((Double(testLevel.level) * 0.4325 + 7.0048))) + 12.2
        delegate?.lapedUpDelegate(self, lap: Int(lap + 1), distance: Int(distance), vO2Max: vO2Max)
        runLap()
    }
}
