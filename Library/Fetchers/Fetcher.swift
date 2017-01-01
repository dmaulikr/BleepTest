import Foundation
import DATAStack
import Sync
import DATASource
import CoreData

public class Fetcher : NSObject {
    private var data: DATAStack
    
    // MARK: - Initializers

    init(dataStack: DATAStack) {
        self.data = dataStack
    }

    // MARK: - Public methods

    public func persistWithCompletion(completion: () -> ()) {
        data.persistWithCompletion(completion)
    }
    
    public func fetchLocalData(completion: (NSError?) -> Void){
        let url = NSURL(string: "levelsData.json")!
        let filePath = NSBundle.mainBundle().pathForResource(url.URLByDeletingPathExtension?.absoluteString, ofType: url.pathExtension)!
        let jsonData = NSData(contentsOfFile: filePath)!
        let json = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! [String: AnyObject]
        self.data.performInNewBackgroundContext { backgroundContext in
            Sync.changes(json["bleepTest"] as! Array, inEntityNamed: "TestLevel", predicate: nil, parent: nil, inContext: backgroundContext, dataStack: self.data, completion: { error in
                completion(error)
            })
        }
    }

    public func fetchTestLevels(completion: (NSError?) -> Void) -> [TestLevel] {
        let request = NSFetchRequest(entityName: "TestLevel")
        request.sortDescriptors = [NSSortDescriptor(key: "level", ascending: true)]
        let levels = (try! data.mainContext.executeFetchRequest(request) as! [TestLevel])
        return levels
    }
    
    public func fetchCompletedTest(completion: (NSError?) -> Void) -> [CompletedTest] {
        let request = NSFetchRequest(entityName: "CompletedTest")
        request.sortDescriptors = [NSSortDescriptor(key: "createdDate", ascending: false)]
        let tests = (try! data.mainContext.executeFetchRequest(request) as! [CompletedTest])
        return tests
    }
    
    public func fetchUsers(completion: (NSError?) -> Void) -> [Player] {
        let request = NSFetchRequest(entityName: "Player")
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
        let players = (try! data.mainContext.executeFetchRequest(request) as! [Player])
        return players
    }
    
}


extension Fetcher {
    // MARK: DATASource helpers
    
    public func dataSource(tableView: UITableView, cellIdentifier: String, fetchRequest: NSFetchRequest, sectionName: String? = nil, configuration: (cell: UITableViewCell, item: NSManagedObject, indexPath: NSIndexPath) -> ()) -> DATASource {
        return DATASource(tableView: tableView, cellIdentifier: cellIdentifier, fetchRequest: fetchRequest, mainContext: self.data.mainContext, sectionName: sectionName, configuration: configuration)
    }

    public func dataSource(collectionView: UICollectionView, cellIdentifier: String, fetchRequest: NSFetchRequest, mainContext: NSManagedObjectContext, sectionName: String? = nil, configuration: (cell: UICollectionViewCell, item: NSManagedObject, indexPath: NSIndexPath) -> ()) -> DATASource {
        return DATASource(collectionView: collectionView, cellIdentifier: cellIdentifier, fetchRequest: fetchRequest, mainContext: self.data.mainContext, sectionName: sectionName, configuration: configuration)
    }
}