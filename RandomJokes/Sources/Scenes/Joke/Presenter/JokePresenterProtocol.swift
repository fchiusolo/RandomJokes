import Foundation

protocol JokePresenterProtocol {
    func update(joke: Joke)
    func update(error: Error)
}
