import Foundation

protocol JokeViewProtocol {
    func show(joke: String, on subject: String)
    func show(error: String)
}
