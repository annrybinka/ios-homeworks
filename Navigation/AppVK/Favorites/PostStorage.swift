import Foundation
import CoreData

protocol PostStorageProtocol {
    func save(post: Post, handler: @escaping (Bool) -> Void)
    func getAll(handler: @escaping ([Post]) -> Void)
}

final class PostStorage: PostStorageProtocol {
    private var objectModel: NSManagedObjectModel?
    private var storeCoordinator: NSPersistentStoreCoordinator?
    private lazy var context: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = storeCoordinator
        return context
    }()
    
    init() {
        setUpCoreData()
    }
    
    private func setUpCoreData() {
        guard let url = Bundle.main.url(forResource: "Navigation", withExtension: "momd") else { fatalError() }
        
        guard let model = NSManagedObjectModel(contentsOf: url) else { fatalError() }
        objectModel = model
        
        storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel!)
        guard let persistentStoreUrl = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent("NavigationSqlite") else { return }
        do {
            _ = try storeCoordinator!.addPersistentStore(
                type: .sqlite,
                at: persistentStoreUrl,
                options: [NSMigratePersistentStoresAutomaticallyOption: true]
            )
        } catch {
            print(Error.self)
        }
    }
    
    func save(post: Post, handler: @escaping (Bool) -> Void) {
        let model = PostCoreDataModel(context: context, post: post)
        
        guard context.hasChanges else {
            print("PostStorage: post already saved")
            return
        }
        do {
            try context.save()
            handler(true)
        } catch {
            print(error.localizedDescription)
            handler(false)
        }
    }
    
    func getAll(handler: @escaping ([Post]) -> Void) {
        let request = PostCoreDataModel.fetchRequest()
        do {
            let models = try context.fetch(request)
            handler(models.map { Post(coreDataModel: $0) })
        } catch {
            print(Error.self)
            handler([])
        }
    }
}
