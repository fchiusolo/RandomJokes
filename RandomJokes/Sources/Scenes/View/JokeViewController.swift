import UIKit

class JokeViewController: UIViewController {
	@IBOutlet weak var jokeLabel: UILabel!
	var jokeInteractor: JokeInteractorProtocol?
}

// MARK:- ViewController lifecycle
extension JokeViewController {
	override func viewDidAppear(_ animated: Bool) {
		setup()
		jokeInteractor?.fetchJoke()
	}

	private func setup() {
		let presenter = JokePresenter(view: self)
		jokeInteractor = JokeInteractor(presenter: presenter, repository: JokeRepository())
	}
}

extension JokeViewController: JokeViewProtocol {
	func show(joke: String) {
		jokeLabel.text = joke
	}
}
