import Foundation
import CoreData

@objc(Player)
open class Player: NSManagedObject {
    @NSManaged var username: String
    @NSManaged var age: NSNumber
    @NSManaged var dateAdded: Date
    @NSManaged var commpletedTests: Set<CompletedTest>
    @NSManaged var teams: Set<Team>
}
