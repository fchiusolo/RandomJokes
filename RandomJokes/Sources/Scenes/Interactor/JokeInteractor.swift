import Foundation

struct JokeInteractor {
	let presenter: JokePresenterProtocol
	let repository: JokeRepositoryProtocol
}

extension JokeInteractor: JokeInteractorProtocol {
	func fetchJoke() {
		repository.getJoke(firstName: "Daniele", lastName: "Campogiani") { result in
			switch result {
			case .success(let joke):
				self.presenter.update(joke: joke)
			case .failure(let error):
				debugPrint(error.localizedDescription)
			}
		}
	}
}
