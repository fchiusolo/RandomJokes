import Foundation

class ChuckJokeRequest: Request<Joke> {
    let repository: JokesRepositoryProtocol

    init(repository: JokesRepositoryProtocol) {
        self.repository = repository
    }

    override func execute(success: @escaping (Joke) -> Void, failure: @escaping (Error) -> Void) {
        repository.fetch(person: nil) {
            switch $0 {
            case .success(let joke):
                success(joke)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
