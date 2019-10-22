import UIKit

class JokeViewController: UIViewController {
    @IBOutlet weak var jokeLabel: UILabel!
    var jokeInteractor: JokeInteractorProtocol!
}

extension JokeViewController: Storyboarded {}

extension JokeViewController {
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(refresh))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        jokeInteractor.fetch()
    }
}

extension JokeViewController {
    @objc func refresh() {
        jokeInteractor.fetch()
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
