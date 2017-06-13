import Foundation
import CoreData

@objc(Team)

open class Team: NSManagedObject {
    
    convenience init(name: String, teamDescription: String? = nil, players: Set<Player>? = nil, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.teamDescription = teamDescription
        self.players = players
    }
    
    @NSManaged var name: String
    @NSManaged var teamDescription: String?
    @NSManaged var players: Set<Player>?
}
