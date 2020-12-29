import Foundation

struct JokesRepository {}

extension JokesRepository: JokesRepositoryProtocol {
    func fetch(person: Person?, _ handler: @escaping (Result<(Joke, Person?), JokesError>) -> Void) {
        request(.randomJoke(person: person)) { result in
            handler(result.map { ($0, person) })
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
                    .map(\.value)
                    .map(Result.success)
                    ?? .failure(JokesError.parsing)

                DispatchQueue.main.async {
                    handler(result)
                }
            }
            .resume()
    }
}
