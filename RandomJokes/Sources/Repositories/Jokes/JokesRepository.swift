import Foundation

struct JokesRepository {}

extension JokesRepository: JokesRepositoryProtocol {
    func request(for person: Person?) -> Request<Joke> {
        return person.map(PersonJokeRequest.init) ?? ChuckJokeRequest()
    }

    func fetch(person: Person?, _ handler: @escaping (Result<Joke, JokesError>) -> Void) {
        request(.randomJoke(person: person), then: handler)
    }

    private func request(_ endpoint: Endpoint, then handler: @escaping (Result<Joke, JokesError>) -> Void) {
        guard let url = endpoint.url else {
            handler(.failure(JokesError.invalidURL))
            return
        }

        URLSession.shared
            .dataTask(with: url) { data, _, error in
                if let error = error {
                    DispatchQueue.main.async {
                        handler(.failure(.network(error)))
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        handler(.failure(JokesError.emptyData))
                    }
                    return
                }

                let result = (try? JSONDecoder().decode(RandomJokeResponse.self, from: data))
                    .map { $0.value }
                    .map(Result.success)
                    ?? .failure(JokesError.parsing)

                DispatchQueue.main.async {
                    handler(result)
                }
        }
        .resume()
    }
}

private class PersonJokeRequest: Request<Joke> {
    let person: Person

    init(person: Person) {
        self.person = person
    }

    override func execute(success: @escaping (Joke) -> Void, failure: @escaping (Error?) -> Void) {
        JokesRepository().fetch(person: person) {
            switch $0 {
            case .success(let joke):
                success(joke)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

private class ChuckJokeRequest: Request<Joke> {
    override func execute(success: @escaping (Joke) -> Void, failure: @escaping (Error?) -> Void) {
        JokesRepository().fetch(person: nil) {
            switch $0 {
            case .success(let joke):
                success(joke)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
