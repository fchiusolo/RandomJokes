import Foundation

protocol JokePresenterProtocol {
    var view: JokeViewProtocol? { get set }
    func update(joke: Joke)
    func update(error: Error)
}
