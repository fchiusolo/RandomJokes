import Foundation

struct JokesRepository {}

struct JokeWithSubject {
    let joke: Joke
    let subject: String
}

extension Optional where Wrapped == Person {
    var subject: String {
        map { "\($0.firstName) \($0.lastName)" } ?? "Chuck Norris"
    }
}

extension JokesRepository: JokesRepositoryProtocol {
    func fetch(person: Person?, _ handler: @escaping (Result<JokeWithSubject, JokesError>) -> Void) {
        request(.randomJoke(person: person)) { result in
            let resultWithSubject = result.map { JokeWithSubject(joke: $0, subject: person.subject)}
            handler(resultWithSubject)
        }
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
