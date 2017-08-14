import XCTest
import Sync
import CoreData
import Foundation
@testable import BleepTest

class WriterTests: XCTestCase {
    
    var dataStack: DataStack = DataStack()
    
    func createDataStack(_ storeType: DataStackStoreType = .inMemory) -> DataStack {
        let dataStack = DataStack(modelName: "iOS", bundle: Bundle.main, storeType:storeType)
        return dataStack
    }
    
    func fetchObjectsInContext(_ context: NSManagedObjectContext, entity: String) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let objects = try! context.fetch(request) as! [NSManagedObject]
        
        return objects
    }
    
    override func setUp() {
        dataStack = self.createDataStack()
    }
    
    func testCreatePlayer(){
        
        let writer = Writer(dataStack: dataStack)
        writer.createPlayer("John Gwyn", age: 10)
        
        let objects = self.fetchObjectsInContext(dataStack.mainContext, entity: "Player")
        XCTAssertEqual(objects.count, 1)
    }
    
    func testCreateCompletedTest(){
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "Player", into: dataStack.mainContext)
        user.setValue(101, forKey: "age")
        user.setValue("Billy Jones", forKey: "username")
        try! dataStack.mainContext.save()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        var objects = try! dataStack.mainContext.fetch(request)
        
        let writer = Writer(dataStack: dataStack)
        writer.saveBleepTest(2, lap: 3, vo2Max: 20.3, distance: 50, player: objects[0] as? Player)
        
        objects = self.fetchObjectsInContext(dataStack.mainContext, entity: "CompletedTest")
        XCTAssertEqual(objects.count, 1)
    }
    
    func testCreateTeam() {
        dataStack.performInNewBackgroundContext { backgroundContext in
            let entity = NSEntityDescription.entity(forEntityName: "Player", in: backgroundContext)!
            let object = NSManagedObject(entity: entity, insertInto: backgroundContext)
            object.setValue("Bob Jones", forKey: "username")
            object.setValue(27, forKey: "age")
            object.setValue(NSDate(), forKey:  "dateAdded")
            try! backgroundContext.save()
        }
        
        let requestPlayers = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        let objects = try! self.dataStack.mainContext.fetch(requestPlayers) as! [Player]
        
        var players = Set<Player>()
        players.insert(objects[0])
        
        let writer = Writer(dataStack: dataStack)
        writer.createTeam(name: "Test name", description:"Testing", players: players)
        
        let savedTeams = self.fetchObjectsInContext(dataStack.mainContext, entity: "Team")
        let team = savedTeams[0] as! Team
        
        XCTAssertEqual(team.name, "Test name")
        XCTAssertEqual(team.teamDescription, "Testing")
        XCTAssertEqual(team.players, players)

    }
}
