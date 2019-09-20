import Foundation

protocol JokeRepositoryProtocol {
	typealias JokeResponseHandler = (Result<Joke, JokeError>) -> Void
	func getJoke(firstName: String, lastName: String, _ handler: @escaping JokeResponseHandler)
}
