import UIKit

class JokeViewController: UIViewController {
    @IBOutlet var jokeLabel: UILabel!
    var jokeInteractor: JokeInteractorProtocol!
}

extension JokeViewController: Storyboarded {}

extension JokeViewController {
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(refresh))
    }

    override func viewDidAppear(_: Bool) {
        jokeInteractor.fetch()
    }
}

extension JokeViewController {
    @objc func refresh() {
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
            .fadeIn(0.75),
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
