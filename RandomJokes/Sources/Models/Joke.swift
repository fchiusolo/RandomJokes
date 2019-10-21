import Foundation

struct Joke {
    let id: Int
    let text: String
}

extension Joke: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case text = "joke"
    }
}
