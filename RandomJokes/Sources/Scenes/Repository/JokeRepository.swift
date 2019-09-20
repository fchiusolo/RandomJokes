import Foundation

enum JokeError: Error {
	case apiError
	case parsingError
}

struct JokeRepository {
}

extension JokeRepository: JokeRepositoryProtocol {
	func getJoke(firstName: String, lastName: String, _ handler: @escaping (Result<Joke, JokeError>) -> Void) {
		guard let url = getUrl(firstName: "Ciccio", lastName: "Pacciani") else { return }
		URLSession.shared
			.dataTask(with: url) { data, _, _ in
				DispatchQueue.main.async {
					handler(self.parse(data: data))
				}
			}
			.resume()
	}

	func parse(data: Data?) -> Result<Joke, JokeError> {
		guard let data = data else { return .failure(JokeError.apiError) }
		return (try? JSONDecoder().decode(RandomJokeResponse.self, from: data))
			.map { .success($0.value) }
			?? .failure(JokeError.parsingError)
	}

	private func getUrl(firstName: String, lastName: String) -> URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.icndb.com"
		components.path = "/jokes/random"
		components.queryItems = [
			URLQueryItem(name: "firstName", value: firstName),
			URLQueryItem(name: "lastName", value: lastName)
		]
		return components.url
	}
}
