import Foundation

class Request<T> {
    func execute(success _: @escaping (T) -> Void, failure _: @escaping (Error) -> Void) {}

    func map<U>(_ transform: @escaping (T) -> U) -> Request<U> {
        MappedRequest(request: self, transform: transform)
    }

    func chain<U>(success: @escaping (T) -> Request<U>, failure: @escaping (Error) -> Request<U>) -> Request<U> {
        ChainedRequest(request: self, success: success, failure: failure)
    }
}

private class ChainedRequest<T, U>: Request<U> {
    let request: Request<T>
    let success: (T) -> Request<U>
    let failure: (Error) -> Request<U>

    init(request: Request<T>, success: @escaping (T) -> Request<U>, failure: @escaping (Error) -> Request<U>) {
        self.request = request
        self.success = success
        self.failure = failure
    }

    override func execute(success: @escaping (U) -> Void, failure: @escaping (Error) -> Void) {
        request.execute(
            success: { self.success($0).execute(success: success, failure: failure) },
            failure: { self.failure($0).execute(success: success, failure: failure) }
        )
    }
}

private class MappedRequest<T, U>: Request<U> {
    let request: Request<T>
    let transform: (T) -> U

    init(request: Request<T>, transform: @escaping (T) -> U) {
        self.request = request
        self.transform = transform
    }

    override func execute(success: @escaping (U) -> Void, failure: @escaping (Error) -> Void) {
        request.execute(
            success: { success(self.transform($0)) },
            failure: failure
        )
    }
}
