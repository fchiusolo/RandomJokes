import Foundation

enum JokeError: Error {
	case invalidURL
	case emptyData
	case parsing
	case network(Error)
}

struct JokeRepository {
}

extension JokeRepository: JokeRepositoryProtocol {
	func getJoke(firstName: String, lastName: String, _ handler: @escaping (Result<Joke, JokeError>) -> Void) {
		request(.randomJoke(firstName: firstName, lastName: lastName), then: handler)
	}

	func request(_ endpoint: Endpoint, then handler: @escaping (Result<Joke, JokeError>) -> Void) {
		guard let url = endpoint.url else {
			handler(.failure(JokeError.invalidURL))
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
						handler(.failure(JokeError.emptyData))
					}
					return
				}

				let result = (try? JSONDecoder().decode(RandomJokeResponse.self, from: data))
					.map { $0.value }
					.map(Result.success)
					?? .failure(JokeError.parsing)

				DispatchQueue.main.async {
					handler(result)
				}
			}
			.resume()
	}
}
