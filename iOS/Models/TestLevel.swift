//https://en.wikipedia.org/wiki/Multi-stage_fitness_test

import Foundation
import CoreData

@objc(TestLevel)
public class TestLevel: NSManagedObject {
    @NSManaged var level: NSNumber
    @NSManaged var laps: NSNumber
    @NSManaged var lapTime: Double
    @NSManaged var speed: Double
    @NSManaged var id: String
}