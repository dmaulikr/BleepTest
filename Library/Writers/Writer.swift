import Foundation
import DATAStack
import CoreData

public class Writer : NSObject {

    private var data: DATAStack
    
    // MARK: - Initializers
    init(dataStack: DATAStack) {
        self.data = dataStack
    }
    
    public func saveBleepTest(level:Int, lap:Int, vo2Max:Double, distance:Int){
        self.data.performInNewBackgroundContext { backgroundContext in
            let entity = NSEntityDescription.entityForName("CompletedTest", inManagedObjectContext: backgroundContext)!
            let object = NSManagedObject(entity: entity, insertIntoManagedObjectContext: backgroundContext)
            object.setValue(level, forKey: "level")
            object.setValue(lap, forKey: "lap")
            object.setValue(vo2Max, forKey: "vo2Max")
            object.setValue(distance, forKey: "distance")
            object.setValue(NSDate(), forKey: "createdDate")
            try! backgroundContext.save()
        }
    }
    
    public func createPlayer(username:String, age:Int){
        self.data.performInNewBackgroundContext { backgroundContext in
            let entity = NSEntityDescription.entityForName("Player", inManagedObjectContext: backgroundContext)!
            let object = NSManagedObject(entity: entity, insertIntoManagedObjectContext: backgroundContext)
            object.setValue(username, forKey: "username")
            object.setValue(age, forKey: "age")
            try! backgroundContext.save()
        }
    }
}