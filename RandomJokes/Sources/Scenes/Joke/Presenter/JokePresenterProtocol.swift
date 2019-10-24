import Foundation

protocol JokePresenterProtocol {
    func update(data: (joke: Joke, subject: Person?))
    func update(error: Error)
}
