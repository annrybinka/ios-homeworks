import Foundation

struct Post {
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
}

let dataSource = [
    Post(
        author: "Mary Asana",
        description: "Text about yoga, about yoga, about yoga, about yoga, about yoga, about yoga, about yoga, about yoga, about yoga",
        image: "yoga",
        likes: 15,
        views: 30
    ),
    Post(
        author: "Chef Harry",
        description: "10 egg breakfast recipes",
        image: "food",
        likes: 21,
        views: 45
    ),
    Post(
        author: "Nike dairy",
        description: "Just do it",
        image: "sport",
        likes: 13,
        views: 101
    ),
    Post(
        author: "Buy a new Hyundai 2023 from an authorized dealer",
        description: "The best cars this year",
        image: "cars",
        likes: 99,
        views: 156
    )
]
