import Foundation

protocol JokeInteractorProtocol {
    var presenter: JokePresenterProtocol? { get set }
    func fetch()
}
