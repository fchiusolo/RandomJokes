import Foundation

class Request<T> {
    func execute(success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {}

    func map<R>(transform: @escaping (T) -> R) -> Request<R> {
        return MappedRequest(request: self, transform: transform)
    }

    func chain<R>(success: @escaping (T) -> Request<R>, failure: @escaping (Error?) -> Request<R>) -> Request<R> {
        return ChainedRequest(request: self, success: success, failure: failure)
    }
}

private class ChainedRequest<T, R>: Request<R> {
    let request: Request<T>
    let success: (T) -> Request<R>
    let failure: (Error) -> Request<R>

    init(request: Request<T>, success: @escaping (T) -> Request<R>, failure: @escaping (Error) -> Request<R>) {
        self.request = request
        self.success = success
        self.failure = failure
    }

    override func execute(success: @escaping (R) -> Void, failure: @escaping (Error) -> Void) {
        request.execute(
            success: { self.success($0).execute(success: success, failure: failure) },
            failure: { self.failure($0).execute(success: success, failure: failure) }
        )
    }
}

private class MappedRequest<T, R>: Request<R> {
    let request: Request<T>
    let transform: (T) -> R

    init(request: Request<T>, transform: @escaping (T) -> R) {
        self.request = request
        self.transform = transform
    }

    override func execute(success: @escaping (R) -> Void, failure: @escaping (Error) -> Void) {
        request.execute(
            success: { success(self.transform($0)) },
            failure: failure
        )
    }
}
