import UIKit
import SwiftyTimer
import AVFoundation

class BleepTestController: BaseViewController {
    var levels : [TestLevel]!
    var testLevel : TestLevel!
    var level : Int!
    var lap : Int!
    var timer : NSTimer!
    var beepSoundEffect : AVAudioPlayer!
    var distance : Int!
    var vO2Max : Double!
    
    lazy var player: Player = {
        let fetchedPlayer = self.fetcher.fetchSelectedPlayer{_ in}
        let temporyPlayer = fetchedPlayer?.first
        return temporyPlayer!
    }()
    
    override func loadView() {
        let view = BleepTestView(frame: UIScreen.mainScreen().bounds)
        view.delegate = self
        self.view = view
        self.title = "Bleep Test"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBarHidden(true)
        UIApplication.sharedApplication().idleTimerDisabled = true
        timer = NSTimer.after(0.5.seconds){
            self.startBleepTest()
        }
        timer.start()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

// MARK: BleepTestViewDelegate
extension BleepTestController :BleepTestViewDelegate {
    func didStopButtonPressed(sender: BleepTestView) {
        writer.saveBleepTest((level+1), lap: (lap+1), vo2Max: vO2Max, distance: distance, player: player)
        timer.invalidate()
        timer = NSTimer.after(10.seconds){
            UIApplication.sharedApplication().idleTimerDisabled = false
            self.timer.invalidate()
        }
        timer.start()
        setStatusBarHidden(false)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: Bleep Test Logic
extension BleepTestController{
    private func startBleepTest(){
        levels = fetcher.fetchTestLevels{_ in}
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

