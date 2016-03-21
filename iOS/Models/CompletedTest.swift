import Foundation
import CoreData

@objc(CompletedTest)

public class CompletedTest: NSManagedObject {
    @NSManaged var vo2Max: Double
    @NSManaged var level: NSNumber
    @NSManaged var lap: NSNumber
    @NSManaged var distance: NSNumber
    @NSManaged var createdDate: NSDate
}