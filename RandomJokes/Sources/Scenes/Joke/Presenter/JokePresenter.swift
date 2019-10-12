import Foundation

struct JokePresenter {
    let view: JokeViewProtocol
}

extension JokePresenter: JokePresenterProtocol {
    func update(joke: Joke) {
        view.show(joke: joke.joke)
    }

    func update(error: Error) {
        view.show(error: error.localizedDescription)
    }
}
