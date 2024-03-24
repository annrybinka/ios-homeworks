import Foundation
import CoreData

extension PostCoreDataModel {
    convenience init(context: NSManagedObjectContext, post: Post) {
        self.init(context: context)
        self.id = post.id
        self.author = post.author
        self.desc = post.description
        self.image = post.image
        self.likes = Int32(post.likes)
        self.views = Int32(post.views)
    }
}
