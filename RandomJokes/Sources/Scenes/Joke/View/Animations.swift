import UIKit

struct Animation<Subject: UIView> {
    let duration: TimeInterval
    let animations: (Subject) -> Void
}

extension Animation {
    static func fadeOut(_ duration: TimeInterval = 1) -> Animation {
        return Animation(duration: duration) {
            $0.alpha = 0
        }
    }

    static func then(_ job: @escaping (Subject) -> Void) -> Animation {
        return Animation(duration: 0, animations: job)
    }

    static func fadeIn(_ duration: TimeInterval = 1) -> Animation {
        return Animation(duration: duration) {
            $0.alpha = 1
        }
    }
}

protocol Animatable {
    associatedtype Subject: UIView
    func animate(_ animations: [Animation<Subject>])
}

extension Animatable where Self: UIView {
    func animate(_ animations: [Animation<Self>]) {
        guard !animations.isEmpty else {
            return
        }

        let animation = animations.first!

        UIView.animate(
            withDuration: animation.duration,
            animations: { animation.animations(self)},
            completion: { [weak self] _ in
                let rest = animations.dropFirst()
                self?.animate(Array(rest))
            }
        )
    }
}

extension UILabel: Animatable {}
