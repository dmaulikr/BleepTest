import Foundation
import DATAStack
import Sync
import DATASource
import CoreData

open class Fetcher : NSObject {
    fileprivate var data: DATAStack
    
    // MARK: - Initializers

    init(dataStack: DATAStack) {
        self.data = dataStack
    }

    // MARK: - Public methods

    open func persistWithCompletion(_ completion: () -> ()) {
        data.persistWithCompletion(completion)
    }
    
    open func fetchLocalData(_ completion: @escaping (NSError?) -> Void){
        let url = URL(string: "levelsData.json")!
        let filePath = Bundle.main.path(forResource: url.deletingPathExtension().absoluteString, ofType: url.pathExtension)!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
        self.data.performInNewBackgroundContext { backgroundContext in
            Sync.changes(json["bleepTest"] as! Array, inEntityNamed: "TestLevel", predicate: nil, parent: nil, inContext: backgroundContext, dataStack: self.data, completion: { error in
                completion(error)
            })
        }
    }

    open func fetchTestLevels(_ completion: (NSError?) -> Void) -> [TestLevel] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TestLevel")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        let levels = (try! data.mainContext.fetch(request) as! [TestLevel])
        return levels
    }
    
    open func fetchCompletedTest(_ completion: (NSError?) -> Void) -> [CompletedTest] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CompletedTest")
        request.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        let tests = (try! data.mainContext.fetch(request) as! [CompletedTest])
        return tests
    }
    
    open func fetchUsers(_ completion: (NSError?) -> Void) -> [Player] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
        let players = (try! data.mainContext.fetch(request) as! [Player])
        return players
    }
    
    open func fetchSelectedPlayer(_ completion: (NSError?) -> Void) -> [Player]? {
        let defaults = UserDefaults.standard
        if((defaults.object(forKey: "selectedPlayerID")) != nil){
            let playerURI = defaults.url(forKey: "selectedPlayerID")
            let playerID: NSManagedObjectID  = (data.mainContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: playerURI!))!
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
            request.predicate = NSPredicate(format: "SELF == %@", playerID)
            let player = (try! data.mainContext.fetch(request)) as? [Player]
            return player
        }
        return nil
    }
}


extension Fetcher {
    // MARK: DATASource helpers
    
    public func dataSource(_ tableView: UITableView, cellIdentifier: String, fetchRequest: NSFetchRequest<NSFetchRequestResult>, sectionName: String? = nil, configuration: @escaping (_ cell: UITableViewCell, _ item: NSManagedObject, _ indexPath: NSIndexPath) -> ()) -> DATASource {
        return DATASource(tableView: tableView, cellIdentifier: cellIdentifier, fetchRequest: fetchRequest, mainContext: self.data.mainContext, sectionName: sectionName, configuration: configuration)
    }

    public func dataSource(_ collectionView: UICollectionView, cellIdentifier: String, fetchRequest: NSFetchRequest<NSFetchRequestResult>, mainContext: NSManagedObjectContext, sectionName: String? = nil, configuration: @escaping (_ cell: UICollectionViewCell, _ item: NSManagedObject, _ indexPath: NSIndexPath) -> ()) -> DATASource {
        return DATASource(collectionView: collectionView, cellIdentifier: cellIdentifier, fetchRequest: fetchRequest, mainContext: self.data.mainContext, sectionName: sectionName, configuration: configuration)
    }
}
