import Foundation
import Sync
import DATASource
import CoreData

open class Fetcher : NSObject {
    fileprivate var dataStack: DataStack
    
    // MARK: - Initializers

    init(dataStack: DataStack) {
        self.dataStack = dataStack
    }

    // MARK: - Public methods

    
    open func fetchLocalData(_ completion: @escaping (NSError?) -> Void){
        let url = URL(string: "levelsData.json")!
        let filePath = Bundle.main.path(forResource: url.deletingPathExtension().absoluteString, ofType: url.pathExtension)!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
        
        self.dataStack.performInNewBackgroundContext { backgroundContext in
            Sync.changes(json, inEntityNamed: "TestLevel", dataStack: self.dataStack,
                         completion: { error in
                completion(error)
            })
        }
    }

    open func fetchTestLevels(_ completion: (NSError?) -> Void) -> [TestLevel] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TestLevel")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        let levels = (try! dataStack.mainContext.fetch(request) as! [TestLevel])
        return levels
    }
    
    open func fetchCompletedTest(_ completion: (NSError?) -> Void) -> [CompletedTest] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedTest")
        request.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        let tests = (try! dataStack.mainContext.fetch(request) as! [CompletedTest])
        return tests
    }
    
    open func fetchUsers(_ completion: (NSError?) -> Void) -> [Player] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
        let players = (try! dataStack.mainContext.fetch(request) as! [Player])
        return players
    }
    
    open func fetchSelectedPlayer(_ completion: (NSError?) -> Void) -> [Player]? {
        let defaults = UserDefaults.standard
        if((defaults.object(forKey: "selectedPlayerID")) != nil){
            let playerURI = defaults.url(forKey: "selectedPlayerID")
            let playerID: NSManagedObjectID  = (dataStack.mainContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: playerURI!))!
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
            request.predicate = NSPredicate(format: "SELF == %@", playerID)
            let player = (try! dataStack.mainContext.fetch(request)) as? [Player]
            return player
        }
        return nil
    }
}


