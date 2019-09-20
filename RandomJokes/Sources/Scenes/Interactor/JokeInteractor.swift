import Foundation

struct JokeInteractor {
	let presenter: JokePresenterProtocol
	let repository: JokeRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
	func fetchJoke() {
		repository.getJoke(firstName: "Ciccio", lastName: "Pacciani") { result in
			switch result {
			case .success(let joke):
				self.presenter.update(joke: joke)
			case .failure(let error):
				debugPrint(error.localizedDescription)
			}
		}
	}
}
