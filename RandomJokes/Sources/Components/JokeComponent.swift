import UIKit
import NeedleFoundation

protocol JokeViewControllerBuilder {
    var jokeViewController: UIViewController { get }
}

class JokeComponent: BootstrapComponent {
    var jokePresenter: JokePresenterProtocol {
        JokePresenter()
    }

    var jokesRepository: JokesRepositoryProtocol {
        JokesRepository()
    }

    var contactsRepository: ContactsRepositoryProtocol {
        ContactsRepository()
    }

    var jokeInteractor: JokeInteractorProtocol {
        JokeInteractor(jokesRepository: jokesRepository,
                       contactsRepository: contactsRepository)
    }
}

extension JokeComponent: JokeViewControllerBuilder {
    var jokeViewController: UIViewController {
        var interactor = jokeInteractor
        var presenter = jokePresenter
        let view = JokeViewController.instantiate()

        presenter.view = view
        interactor.presenter = presenter
        view.jokeInteractor = interactor

        return view
    }
}
