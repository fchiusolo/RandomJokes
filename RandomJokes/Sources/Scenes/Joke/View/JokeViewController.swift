import UIKit

class JokeViewController: UIViewController {
    @IBOutlet weak var jokeLabel: UILabel!
    var jokeInteractor: JokeInteractorProtocol!
}

// MARK:- ViewController lifecycle
extension JokeViewController {
    override func viewDidLoad() {
        jokeInteractor = JokeInteractor(presenter: JokePresenter(view: self),
                                        jokesRepository: JokesRepository(),
                                        contactsRepository: ContactsRepository())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        jokeInteractor.fetchJoke()
    }
}

// MARK:- Actions
extension JokeViewController {
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        jokeInteractor.fetchJoke()
    }
}

extension JokeViewController: JokeViewProtocol {
    func show(joke: String) {
        jokeLabel.textColor = .black
        jokeLabel.text = joke
    }

    func show(error: String) {
        jokeLabel.textColor = .red
        jokeLabel.text = error
    }
}
