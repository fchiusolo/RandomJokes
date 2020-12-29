import Foundation

struct JokePresenter {
    var view: JokeViewProtocol?
}

extension JokePresenter: JokePresenterProtocol {
    func update(data: (joke: Joke, subject: Person?)) {
        let encodedJokeText = data.joke.text
        let subject = data.subject.toString
        guard let jokeText = String(htmlEncodedString: encodedJokeText) else { return }

        view?.show(joke: jokeText, on: subject)
    }

    func update(error: Error) {
        view?.show(error: error.localizedDescription)
    }
}

private extension Optional where Wrapped == Person {
    var toString: String {
        map { "\($0.firstName) \($0.lastName)" } ?? "Chuck Norris"
    }
}
