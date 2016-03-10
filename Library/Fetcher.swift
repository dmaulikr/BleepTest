import Foundation
import DATAStack
import Networking
import JSON
import Sync
import DATASource
import CoreData

public class Fetcher : NSObject {
    private var data: DATAStack
    private var networking: Networking
    private var localFilePath : NSURL
    
    // MARK: - Initializers

    init(baseURL: String, modelName: String, localFilePath: NSURL) {
        self.data = DATAStack(modelName: modelName)
        self.networking = Networking(baseURL: baseURL)
        self.localFilePath = localFilePath
    }

    // MARK: - Public methods

    public func persistWithCompletion(completion: () -> ()) {
        data.persistWithCompletion(completion)
    }
    
    public func fetchLocalData(completion: (NSError?) -> Void){
        
        let filePath = NSBundle.mainBundle().pathForResource(localFilePath.URLByDeletingPathExtension?.absoluteString, ofType: localFilePath.pathExtension)!
        let data = NSData(contentsOfFile: filePath)!
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String: AnyObject]
        self.data.performInNewBackgroundContext { backgroundContext in            
            Sync.changes(json["bleepTest"] as! Array, inEntityNamed: "TestLevel", predicate: nil, parent: nil, inContext: backgroundContext, dataStack: self.data, completion: { error in
                completion(error)
            })
        }
    }

    public func someResource(completion: (error: NSError?) -> ()) {
        self.networking.GET("/someResource") { JSON, error in
            if let JSON = JSON as? [[String : AnyObject]] {
                Sync.changes(JSON, inEntityNamed: "SomeEntityName", dataStack: self.data, completion: { error in
                    completion(error: error)
                })
            } else {
                completion(error: error)
            }
        }
    }
    
    func changeNotification(notification: NSNotification) {
        let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey]
        let deletedObjects = notification.userInfo?[NSDeletedObjectsKey]
        let insertedObjects = notification.userInfo?[NSInsertedObjectsKey]
        print("updatedObjects: \(updatedObjects)")
        print("deletedObjects: \(deletedObjects)")
        print("insertedObjects: \(insertedObjects)")
    }
}

// MARK: DATASource helpers

extension Fetcher {
    public func dataSource(tableView: UITableView, cellIdentifier: String, fetchRequest: NSFetchRequest, sectionName: String? = nil, configuration: (cell: UITableViewCell, item: NSManagedObject, indexPath: NSIndexPath) -> ()) -> DATASource {
        return DATASource(tableView: tableView, cellIdentifier: cellIdentifier, fetchRequest: fetchRequest, mainContext: self.data.mainContext, sectionName: sectionName, configuration: configuration)
    }

    public func dataSource(collectionView: UICollectionView, cellIdentifier: String, fetchRequest: NSFetchRequest, mainContext: NSManagedObjectContext, sectionName: String? = nil, configuration: (cell: UICollectionViewCell, item: NSManagedObject, indexPath: NSIndexPath) -> ()) -> DATASource {
        return DATASource(collectionView: collectionView, cellIdentifier: cellIdentifier, fetchRequest: fetchRequest, mainContext: self.data.mainContext, sectionName: sectionName, configuration: configuration)
    }
}