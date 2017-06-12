import XCTest
import Sync
import CoreData
@testable import BleepTest

class TestTeam: XCTestCase {
    
    func createDataStack() -> DataStack {
        let dataStack = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:.inMemory)
        return dataStack
    }
    
    func testInit_ShouldTakeName() {
        let item = Team(name: "Test name")
        XCTAssertEqual(item.name, "Test name", "Name item should not be nil")
    }
    
    func testInit_ShouldTakeNameAndDescription() {
        let item = Team(name: "Test name", teamDescription: "This is my team")
        XCTAssertEqual(item.teamDescription, "This is my team", "Team description should not be not nil")
    }
    
    func testInit_ShouldTakeNameAndPlayers() {
        let dataStack = self.createDataStack()
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "Player", into: dataStack.mainContext)
        user.setValue(101, forKey: "age")
        user.setValue("Billy Jones", forKey: "username")
        try! dataStack.mainContext.save()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        let objects = try! dataStack.mainContext.fetch(request)
        
        
        let item = Team(name: "Test name", players: objects as? [Player])
        XCTAssertEqual(item.players?[0].username, "Billy Jones", "Players should not be not nil")

    }
    
}
