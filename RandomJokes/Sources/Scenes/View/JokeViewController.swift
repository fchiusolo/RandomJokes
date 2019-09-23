import UIKit

class JokeViewController: UIViewController {
	@IBOutlet weak var jokeLabel: UILabel!
	var jokeInteractor: JokeInteractorProtocol?
}

// MARK:- ViewController lifecycle
extension JokeViewController {
	override func viewDidAppear(_ animated: Bool) {
		let presenter = JokePresenter(view: self)
		jokeInteractor = JokeInteractor(presenter: presenter, repository: JokeRepository())
	}
}

// MARK:- Actions
extension JokeViewController {
	@IBAction func refresh(_ sender: UIBarButtonItem) {
		jokeInteractor?.fetchJoke()
	}
}

extension JokeViewController: JokeViewProtocol {
	func show(joke: String) {
		jokeLabel.text = joke
	}
}
