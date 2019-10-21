import Foundation

struct RandomJokeResponse {
    let type: String
    let value: Joke
}

extension RandomJokeResponse: Codable {}
