import Foundation
import CoreData

@objc(Player)
public class Player: NSManagedObject {
    @NSManaged var username: String
    @NSManaged var age: NSNumber
    @NSManaged var dateAdded: NSDate
    @NSManaged var commpletedTests: Set<CompletedTest>
}
