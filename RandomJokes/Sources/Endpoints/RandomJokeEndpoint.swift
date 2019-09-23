import Foundation

extension Endpoint {
	var url: URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.icndb.com"
		components.path = path
		components.queryItems = queryItems
		return components.url
	}

	static func randomJoke(firstName: String, lastName: String) -> Endpoint {
		return Endpoint(path: "/jokes/random",
						queryItems: [
							URLQueryItem(name: "firstName", value: firstName),
							URLQueryItem(name: "lastName", value: lastName)
			])
	}
}
