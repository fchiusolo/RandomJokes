import Foundation

enum JokesError: Error {
    case invalidURL
    case emptyData
    case parsing
    case network(Error)
}

protocol JokesRepositoryProtocol {
    typealias JokesResponseHandler = (Result<JokeWithSubject, JokesError>) -> Void

    func fetch(person: Person?, _ handler: @escaping JokesResponseHandler)
}
