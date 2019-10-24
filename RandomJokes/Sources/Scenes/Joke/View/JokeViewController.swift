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
        UIView.animate(withDuration: 0.5, animations: { [weak self] in self?.fadeOut() }) { [weak self] _ in
            self?.jokeLabel.textColor = .black
            self?.jokeLabel.attributedText = joke.highlight(subject, with: .red)

            UIView.animate(withDuration: 0.5) { [weak self] in self?.fadeIn() }
        }
    }

    private func fadeOut() {
        jokeLabel.alpha = 0
    }

    private func fadeIn() {
        jokeLabel.alpha = 1
    }

    func show(error: String) {
        jokeLabel.textColor = .red
        jokeLabel.text = error
    }
}

private extension String {
    func highlight(_ substring: String, with color: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.foregroundColor,
                                      value: color,
                                      range: range(of: substring))
        return attributedString
    }

    func range(of substring: String) -> NSRange {
        return NSString(string: self).range(of: substring)
    }
}
