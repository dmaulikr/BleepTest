import UIKit
import SwiftyTimer
import AVFoundation

class BleepTestController: BaseViewController {
    var levels : [TestLevel]!
    var testLevel : TestLevel!
    var level : Int!
    var lap : Int!
    var timer : NSTimer!
    var beepSoundEffect: AVPlayer!
    
    override func loadView() {
        let view = BleepTestView(frame: UIScreen.mainScreen().bounds)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationObservers()
    }
    
    private func notificationObservers(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "bleepTestStarted:",
            name: startTestNotificationKey,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "bleepTestStoped:",
            name: stopTestNotificationKey,
            object: nil)
    }

    private func levelRun(i : Int){
        if (i != levels.count){
            testLevel = levels[i]
            lap = 0
          //  let levelDictionary = ["level" : String(testLevel.level)]
            NSNotificationCenter.defaultCenter().postNotificationName(leveledUpNotificationKey,
                object: nil,
                userInfo: ["level" : String(testLevel.level)])
            print("laps \(testLevel.laps)")
            runLap()
        } else{
            beep()
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
        timer = NSTimer.after(lapTime.seconds){
            self.lapFinished()
        }
        timer.start()
    }
    
    private func beep(){
        let path = NSBundle.mainBundle().pathForResource("beep.wav", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        
        let sound =  AVPlayer(URL: url)
        beepSoundEffect = sound
        beepSoundEffect.play()
    }
    
    private func lapFinished(){
        lap = lap + 1
        print("Lap \(lap) finished.")
        runLap()
    }
    
    @objc private func bleepTestStoped(notification: NSNotification){
        timer.invalidate()
    }
    
    @objc private func bleepTestStarted(notification: NSNotification){
        levels = fetcher.fetchTestLevels{_ in}
        level = 0
        levelRun(level)
    }
    
}
