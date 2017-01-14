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
