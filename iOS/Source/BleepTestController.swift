import UIKit
import SwiftyTimer
import AVFoundation

class BleepTestController: BaseViewController {
    var testLevel : TestLevel!
    var level : Int!
    var lap : Int!
    var distance : Int!
    var vO2Max : Double!
    
    lazy var bleepTest: BleepTest = {
        let levels = self.fetcher.fetchTestLevels{_ in}
        let temporyBleepTest = BleepTest(bleepTestLevels: levels)
        temporyBleepTest.delegate = self
        return temporyBleepTest
    }()
    
    lazy var player: Player = {
        let fetchedPlayer = self.fetcher.fetchSelectedPlayer{_ in}
        let temporyPlayer = fetchedPlayer?.first
        return temporyPlayer!
    }()
    
    lazy var rootView: BleepTestView = {
        var temporyView = BleepTestView(frame: UIScreen.mainScreen().bounds)
        temporyView.delegate = self
        return temporyView
    }()
    
    override func loadView() {
        self.bleepTest.delegate = self
        self.view = self.rootView
        self.title = "Bleep Test"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStatusBarHidden(true)
        UIApplication.sharedApplication().idleTimerDisabled = true
        self.bleepTest.start()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

// MARK: BleepTestDelegate
extension BleepTestController : BleepTestDelegate {
    func lapedUpDelegate(sender: BleepTest, lap: Int, distance: Int, vO2Max: Double) {
    }
    
    func newLevelDelegate(sender: BleepTest, numberOfLaps: Int, level: Int, lapTime: Double) {
    }
    
    func startedNewLap(sender: BleepTest, lap: Int, lapTime: Double) {
    }
    
    func bleepTestFinished(sender: BleepTest) {
    }
}

// MARK: BleepTestViewDelegate
extension BleepTestController : BleepTestViewDelegate {
    func didStopButtonPressed(sender: BleepTestView) {
        self.bleepTest.stop()
        writer.saveBleepTest((level+1), lap: (lap+1), vo2Max: vO2Max, distance: distance, player: player)
        setStatusBarHidden(false)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
