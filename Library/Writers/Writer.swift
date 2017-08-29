import Foundation
import Sync
import CoreData

open class Writer : NSObject {

    fileprivate var data: DataStack
    
    // MARK: - Initializers
    init(dataStack: DataStack) {
        self.data = dataStack
    }
    
    open func saveBleepTest(_ level:Int, lap:Int, vo2Max:Double, distance:Int, player: Player?){
        self.data.performInNewBackgroundContext { backgroundContext in
            let entity = NSEntityDescription.entity(forEntityName: "CompletedTest", in: backgroundContext)!
            let object = CompletedTest(entity: entity, insertInto: backgroundContext)
            
            if(player != nil) {
                let predicate = NSPredicate(format: "SELF == %@", (player?.objectID)!)
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
                request.predicate = predicate
                let updatePlayer = (try! backgroundContext.fetch(request))
                object.setValue(updatePlayer.first, forKey: "player")
            }
            
            object.setValue(level, forKey: "level")
            object.setValue(lap, forKey: "lap")
            object.setValue(vo2Max, forKey: "vo2Max")
            object.setValue(distance, forKey: "distance")
            object.setValue(NSDate(), forKey: "createdDate")
            
            try! backgroundContext.save()
        }
    }
    
    open func createPlayer(_ username:String, age:Int){
        self.data.performInNewBackgroundContext { backgroundContext in
            let entity = NSEntityDescription.entity(forEntityName: "Player", in: backgroundContext)!
            let object = NSManagedObject(entity: entity, insertInto: backgroundContext)
            object.setValue(username, forKey: "username")
            object.setValue(age, forKey: "age")
            object.setValue(NSDate(), forKey:  "dateAdded")
            try! backgroundContext.save()
        }
    }
    
    open func setSelectedPlayer(_ player: Player) {
        let defaults = UserDefaults.standard
        defaults.set(player.objectID.uriRepresentation(), forKey: "selectedPlayerID")
    }
    
    open func createTeam(name: String, description: String, players: Set<Player>? = nil) {
        self.data.performInNewBackgroundContext { backgroundContext in
            let entity = NSEntityDescription.entity(forEntityName: "Team", in: backgroundContext)!
            let object = NSManagedObject(entity: entity, insertInto: backgroundContext)
            object.setValue(name, forKey: "name")
            object.setValue(description, forKey: "teamDescription")
            
            if(players != nil) {
                let items = object.mutableSetValue(forKey: "players");
                for player in players as Set<Player>! {
                    items.add(player)
                }
            }
            
            try! backgroundContext.save()
        }
    }
    
}
