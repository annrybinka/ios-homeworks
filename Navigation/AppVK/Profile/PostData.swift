import Foundation

struct Post {
    let id: String
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
    
    init(id: String, author: String, description: String, image: String, likes: Int, views: Int) {
        self.id = id
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
    
    init(coreDataModel: PostCoreDataModel) {
        self.id = coreDataModel.id ?? ""
        self.author = coreDataModel.author ?? ""
        self.description = coreDataModel.desc ?? ""
        self.image = coreDataModel.image ?? ""
        self.likes = Int(coreDataModel.likes)
        self.views = Int(coreDataModel.views)
    }
}

let dataSource = [
    Post(
        id: "1",
        author: "Yoga with Mary Asana",
        description: "Text about yoga, about yoga, about yoga, about yoga, about yoga, about yoga and yoga",
        image: "yoga",
        likes: 15,
        views: 30
    ),
    Post(
        id: "2",
        author: "Chef Dexter Morgan",
        description: "10 egg breakfast recipes mmm... try them all 😉",
        image: "food",
        likes: 21,
        views: 45
    ),
    Post(
        id: "3",
        author: "Nike dairy",
        description: "💪 Just do it\n💪💪 Just do it\n💪💪💪 Just do it",
        image: "sport",
        likes: 13,
        views: 101
    ),
    Post(
        id: "4",
        author: "Aurora: Hyundai authorized dealer in Moscow, Russia",
        description: "The best cars this year! Buy a new Hyundai 2024 with discount from an authorized dealer.",
        image: "cars",
        likes: 99,
        views: 156
    )
]
