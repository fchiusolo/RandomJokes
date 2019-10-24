import UIKit

struct Animation {
    let duration: TimeInterval
    let animations: (UIView) -> Void
}

extension Animation {
    static func fadeOut(_ duration: TimeInterval = 1) -> Animation {
        return Animation(duration: duration) {
            $0.alpha = 0
        }
    }

    static func then(_ job: @escaping () -> Void) -> Animation {
        return Animation(duration: 0) { _ in job() }
    }

    static func fadeIn(_ duration: TimeInterval = 1) -> Animation {
        return Animation(duration: duration) {
            $0.alpha = 1
        }
    }
}

extension UIView {
    func animate(_ animations: [Animation]) {
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
