import Foundation

struct JokePresenter {
    let view: JokeViewProtocol
}

extension JokePresenter: JokePresenterProtocol {
    func update(joke: JokeWithSubject) {
        guard let text = String(htmlEncodedString: joke.joke.text) else { return }
        view.show(joke: text, on: joke.subject)
    }

    func update(error: Error) {
        view.show(error: error.localizedDescription)
    }
}
