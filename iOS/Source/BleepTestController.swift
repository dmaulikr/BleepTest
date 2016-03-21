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
    var writer = Writer()
    
    override func loadView() {
        let view = BleepTestView(frame: UIScreen.mainScreen().bounds)
        self.view = view
        self.title = "Bleep Test"
        addMenuButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationObservers()
    }
    
    func addMenuButton(){
        var menuButton = UIButton()
        menuButton = UIButton.menuButton()
        menuButton.addTarget(self, action: Selector("menuAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        let menuBarButton = UIBarButtonItem()
        menuBarButton.customView = menuButton
        self.navigationItem.leftBarButtonItem = menuBarButton
    }
    
    //MARK: Notification
    
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
    
    func bleepTestStoped(notification: NSNotification){
        //Saving the bleeptest need to add 1 to the lap and level.
        writer.saveBleepTest((level+1), lap: (lap+1), vo2Max: vO2Max, distance: distance)
        //Removing the timer that idle is enabled
        timer.invalidate()
        timer = NSTimer.after(10.seconds){
            UIApplication.sharedApplication().idleTimerDisabled = false
            self.timer.invalidate()
        }
        timer.start()
    }
    
    func bleepTestStarted(notification: NSNotification){
        UIApplication.sharedApplication().idleTimerDisabled = true
        levels = fetcher.fetchTestLevels{_ in}
        level = 0
        distance = 0
        levelRun(level)
    }
    
    //MARK: Bar Button Action
    
    func menuAction(sender:UIButton!){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.navigationController!.pushViewController(MenuTableController(fetcher: self.fetcher), animated: true)
    }
    
    // MARK: Bleep Test Logic

    private func levelRun(i : Int){
        if (i != levels.count){
            testLevel = levels[i]
            lap = 0
             vO2Max = 3.46 * (Double(testLevel.level)+Double(lap+1) / ((Double(testLevel.level) * 0.4325 + 7.0048))) + 12.2
            NSNotificationCenter.defaultCenter().postNotificationName(
                leveledUpNotificationKey,
                object: nil,
                userInfo: ["level" : String(testLevel.level)])
            NSNotificationCenter.defaultCenter().postNotificationName(
                lapedUpNotificationKey,
                object: nil,
                userInfo: [
                    "lap":String(lap+1),
                    "distance":String(distance),
                    "VO2Max":String(format: "%.3f", vO2Max)
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
                "VO2Max":String(format: "%.3f", vO2Max)
            ])
        runLap()
    }
    
}
