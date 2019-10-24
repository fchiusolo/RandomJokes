import Foundation

protocol JokePresenterProtocol {
    func update(jokeAndSubject: (Joke, Person?))
    func update(error: Error)
}
