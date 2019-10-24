import UIKit

class JokeViewController: UIViewController {
    @IBOutlet weak var jokeLabel: UILabel!
    var jokeInteractor: JokeInteractorProtocol!
}

extension JokeViewController {
    override func viewDidLoad() {
        jokeInteractor = JokeInteractor(presenter: JokePresenter(view: self),
                                        jokesRepository: JokesRepository(),
                                        contactsRepository: ContactsRepository())
    }

    override func viewDidAppear(_ animated: Bool) {
        jokeInteractor.fetch()
    }
}

extension JokeViewController {
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        jokeInteractor.fetch()
    }
}

extension JokeViewController: JokeViewProtocol {
    func show(joke: String, on subject: String) {
        jokeLabel.animate([
            .fadeOut(0.75),
            .then {
                $0.textColor = .black
                $0.attributedText = joke.highlight(subject, with: .red)
            },
            .fadeIn(0.75)
        ])
    }

    func show(error: String) {
        jokeLabel.textColor = .red
        jokeLabel.text = error
    }
}

private extension String {
    func highlight(_ substring: String, with color: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)

        ranges(of: substring)
            .forEach { attributedString.foreground(color, range: $0) }
        return attributedString
    }
}

private extension NSMutableAttributedString {
    func foreground(_ color: UIColor, range: NSRange) {
        addAttribute(.foregroundColor, value: color, range: range)
    }
}
