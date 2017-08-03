import XCTest
import Sync
import CoreData
@testable import BleepTest

class TeamTest: XCTestCase {
    
    var dataStack: DataStack = DataStack()
    var entity: NSEntityDescription?
    
    override func setUp() {
        self.dataStack = self.createDataStack()
        self.entity = NSEntityDescription.entity(forEntityName: "Team", in: dataStack.mainContext)
        super.setUp()
    }
    
    func createDataStack() -> DataStack {
        let dataStack = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
        return dataStack
    }
    
    func testInit_ShouldTakeName() {
        let item = Team(name: "Test name", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext)
        XCTAssertEqual(item.name, "Test name", "Name item should not be nil")
    }
    
    func testInit_ShouldTakeNameAndDescription() {
        let item = Team(name: "Test name", teamDescription: "This is my team", entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext)
        XCTAssertEqual(item.teamDescription, "This is my team", "Team description should not be not nil")
    }
    
    func testInit_ShouldTakeNameAndPlayers() {
        let user = NSEntityDescription.insertNewObject(forEntityName: "Player", into: self.dataStack.mainContext)
        user.setValue(101, forKey: "age")
        user.setValue("Billy Jones", forKey: "username")
        try! self.dataStack.mainContext.save()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        let objects = try! self.dataStack.mainContext.fetch(request) as! [Player]
        
        var players = Set<Player>()
        players.insert(objects[0])
        
        let item = Team(name: "Test name", players: players, entity: self.entity!, insertIntoManagedObjectContext: self.dataStack.mainContext)
        let player = item.players?.first
        
        XCTAssertEqual(player?.username, "Billy Jones", "Players should not be not nil")
    }
}
