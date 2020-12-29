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

    static func randomJoke(person: Person?) -> Endpoint {
        let queryItems = person.map(Endpoint.queryItems) ?? []
        return Endpoint(path: "/jokes/random", queryItems: queryItems)
    }

    private static func queryItems(for person: Person) -> [URLQueryItem] {
        [
            URLQueryItem(name: "firstName", value: person.firstName),
            URLQueryItem(name: "lastName", value: person.lastName),
        ]
    }
}
