import Foundation
import SwiftyTimer
import AVFoundation

class BleepTest: NSObject {
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
    private func startBleepTest(){
        level = 0
        distance = 0
        levelRun(level)
    }
    
    private func levelRun(i : Int){
        if (i != levels.count){
            testLevel = levels[i]
            lap = 0
            vO2Max = 3.46 * (Double(testLevel.level)+Double(lap+1) / ((Double(testLevel.level) * 0.4325 + 7.0048))) + 12.2
            NSNotificationCenter.defaultCenter().postNotificationName(
                leveledUpNotificationKey,
                object: nil,
                userInfo: [
                    "level" : String(testLevel.level),
                    "numberOfLaps" : testLevel.laps,
                    "lapTime" : testLevel.lapTime
                ])
            NSNotificationCenter.defaultCenter().postNotificationName(
                lapedUpNotificationKey,
                object: nil,
                userInfo: [
                    "lap":String(lap+1),
                    "distance":String(distance),
                    "VO2Max":String(format: "%.1f", vO2Max)
                ])
            runLap()
        } else{
            beep()
            NSNotificationCenter.defaultCenter().postNotificationName(
                stopTestNotificationKey,
                object: self)
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
        NSNotificationCenter.defaultCenter().postNotificationName(
            startedNewLapNotificationKey,
            object: nil,
            userInfo: ["lap":lapTime]
        )
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
        NSNotificationCenter.defaultCenter().postNotificationName(
            lapedUpNotificationKey,
            object: nil,
            userInfo: [
                "lap" : String(lap+1),
                "distance":String(distance),
                "VO2Max":String(format: "%.1f", vO2Max)
            ])
        runLap()
    }
}
