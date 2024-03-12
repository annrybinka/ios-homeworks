import Foundation
import RealmSwift

final class UserRealm: Object {
    @objc dynamic var id: String?
    @objc dynamic var login: String?
    @objc dynamic var password: String?
    
    override class func primaryKey() -> String? {
        "id"
    }
}

protocol StorageProtocol {
    func save(
        newUser: AuthUser,
        handler: @escaping (Bool) -> Void
    )
    func getSavedUser(handler: @escaping (AuthUser?) -> Void)
}

final class Storage: StorageProtocol {
    func save(newUser: AuthUser, handler: @escaping (Bool) -> Void) {
        do {
            let realm = try Realm()
            if realm.isInWriteTransaction {
                realm.create(UserRealm.self, value: newUser.keyedValues)
            } else {
                try realm.write {
                    realm.create(UserRealm.self, value: newUser.keyedValues)
                }
            }
            handler(true)
        } catch {
            handler(false)
        }
    }
    
    func getSavedUser(handler: @escaping (AuthUser?) -> Void) {
        do {
            let realm = try Realm()
            let objects = realm.objects(UserRealm.self)
            let users = objects.map { AuthUser(
                id: $0.id ?? "",
                login: $0.login ?? "",
                password: $0.password ?? ""
            )}
            handler(users.first)
        } catch {
            handler(nil)
        }
    }
}
