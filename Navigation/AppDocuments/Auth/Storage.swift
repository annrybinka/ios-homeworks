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
    static let key64: [UInt8] = [0x72, 0x65, 0x61, 0x6c, 0x6d, 0x31, 0x32, 0x33, 0x34, 0x35, 0x72, 0x65, 0x61, 0x6c, 0x6d, 0x31, 0x32, 0x33, 0x34, 0x35, 0x72, 0x65, 0x61, 0x6c, 0x6d, 0x31, 0x32, 0x33, 0x34, 0x35, 0x72, 0x65, 0x61, 0x6c, 0x6d, 0x31, 0x32, 0x33, 0x34, 0x35, 0x72, 0x65, 0x61, 0x6c, 0x6d, 0x31, 0x32, 0x33, 0x34, 0x35, 0x72, 0x65, 0x61, 0x6c, 0x6d, 0x31, 0x32, 0x33, 0x34, 0x35, 0x30, 0x30, 0x30, 0x30]
    
    func save(newUser: AuthUser, handler: @escaping (Bool) -> Void) {
        let realmKey = Data(Storage.key64)
        let config = Realm.Configuration(encryptionKey: realmKey)
        do {
            let realm = try Realm(configuration: config)
            if realm.isInWriteTransaction {
                realm.create(UserRealm.self, value: newUser.keyedValues)
            } else {
                try realm.write {
                    realm.create(UserRealm.self, value: newUser.keyedValues)
                }
            }
            handler(true)
        } catch {
            print(error.localizedDescription)
            handler(false)
        }
    }
    
    func getSavedUser(handler: @escaping (AuthUser?) -> Void) {
        let realmKey = Data(Storage.key64)
        let config = Realm.Configuration(encryptionKey: realmKey)
        do {
            let realm = try Realm(configuration: config)
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
