import Foundation

final class FavoritesViewModel {
    private let storage: PostStorageProtocol
    var onSavedPostsDidChange: (([Post]) -> Void)?
    
    private(set) var savedPosts: [Post] = [] {
        didSet {
            onSavedPostsDidChange?(savedPosts)
        }
    }
    
    init(storage: PostStorage) {
        self.storage = storage
    }
    
    func onViewWillAppear() {
        storage.getAll { posts in
            self.savedPosts = posts
        }
    }
}
