import Foundation

struct JokePresenter {
    let view: JokeViewProtocol
}

extension JokePresenter: JokePresenterProtocol {
    func update(joke: Joke) {
        guard let text = String(htmlEncodedString: joke.text) else { return }
        view.show(joke: text)
    }
    
    func update(error: Error) {
        view.show(error: error.localizedDescription)
    }
}
