import Foundation

protocol JokePresenterProtocol {
    func update(joke: JokeWithSubject)
    func update(error: Error)
}
