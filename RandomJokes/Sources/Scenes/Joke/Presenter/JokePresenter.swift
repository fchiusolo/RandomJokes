import Foundation

struct JokePresenter {
    let view: JokeViewProtocol
}

extension JokePresenter: JokePresenterProtocol {
    func update(jokeAndSubject: (Joke, Person?)) {
        let encodedJokeText = jokeAndSubject.0.text
        let subject = jokeAndSubject.1.toString
        guard let jokeText = String(htmlEncodedString: encodedJokeText) else { return }
        
        view.show(joke: jokeText, on: subject)
    }
    
    func update(error: Error) {
        view.show(error: error.localizedDescription)
    }
}

private extension Optional where Wrapped == Person {
    var toString: String {
        map { "\($0.firstName) \($0.lastName)" } ?? "Chuck Norris"
    }
}
