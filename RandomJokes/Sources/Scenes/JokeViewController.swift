import UIKit

class JokeViewController: UIViewController {
	@IBOutlet weak var jokeLabel: UILabel!

	override func viewDidAppear(_ animated: Bool) {
		getJoke()
	}
}

private extension JokeViewController {
	func getJoke() {
		guard let url = getUrl(firstName: "Ciccio", lastName: "Pacciani") else { return }
		URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data = data else { return }
			(try? JSONDecoder().decode(RandomJokeResponse.self, from: data))
				.map { [weak self] response in
					DispatchQueue.main.async {
						self?.jokeLabel.text = response.value.joke
					}
			}
		}.resume()
	}

	func getUrl(firstName: String, lastName: String) -> URL? {
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

struct RandomJokeResponse: Codable {
	let type: String
	let value: Joke
}

struct Joke: Codable {
	let id: Int
	let joke: String
}
