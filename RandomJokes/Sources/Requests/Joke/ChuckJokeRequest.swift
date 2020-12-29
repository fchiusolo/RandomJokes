import Foundation

class ChuckJokeRequest: Request<(Joke, Person?)> {
    let repository: JokesRepositoryProtocol

    init(repository: JokesRepositoryProtocol) {
        self.repository = repository
    }

    override func execute(success: @escaping ((Joke, Person?)) -> Void, failure: @escaping (Error) -> Void) {
        repository.fetch(person: nil) {
            switch $0 {
            case let .success(joke):
                success(joke)
            case let .failure(error):
                failure(error)
            }
        }
    }
}
