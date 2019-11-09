import Foundation

protocol JokePresenterProtocol {
    var view: JokeViewProtocol? { get set }
    func update(data: (joke: Joke, subject: Person?))
    func update(error: Error)
}
