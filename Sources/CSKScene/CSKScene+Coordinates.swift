import Foundation
import SpriteKit

public extension CSKScene {

    /// The "highest `SKScene` point" converted from the "highest `SKView` point".
    var viewTop: CGFloat {
        guard let skView = view else {
            return .zero
        }
        return convertPoint(fromView: highestScenePoint(in: skView)).y
    }

    /// The "lowest `SKScene` point" converted from the "lowest`SKView` point".
    var viewBottom: CGFloat {
        guard let skView = view else {
            return .zero
        }
        return convertPoint(fromView: lowestScenePoint(in: skView)).y
    }

    /// The "leftmost `SKScene` point" converted from the "leftmost`SKView` point".
    var viewLeft: CGFloat {
        convertPoint(fromView: .zero).x
    }

    /// The "rightmost `SKScene` point" converted from the "rightmost`SKView` point".
    var viewRight: CGFloat {
        guard let view = view else {
            return .zero
        }
        let point = CGPoint(x: view.bounds.size.width, y: .zero)
        return convertPoint(fromView: point).x
    }
}

// MARK: - Private

private extension SKScene {

    // MARK: Coordinate System

    /*
     macOS uses a different coordinate systems. These functions handle that.
     The #else fallback defaults to iOS-style coordinates and asserts to surface
     unsupported platforms during development.
     */

    func highestScenePoint(in skView: SKView) -> CGPoint {
        let topY: CGPoint
        #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
        topY = .zero
        #elseif os(OSX)
        topY = CGPoint(x: .zero, y: skView.bounds.size.height)
        #else
        assertionFailure("Unsupported platform for highestScenePoint(in:)")
        topY = .zero
        #endif
        return topY
    }

    func lowestScenePoint(in skView: SKView) -> CGPoint {
        let bottomY: CGPoint
        #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
        bottomY = CGPoint(x: .zero, y: skView.bounds.size.height)
        #elseif os(OSX)
        bottomY = .zero
        #else
        assertionFailure("Unsupported platform for lowestScenePoint(in:)")
        bottomY = CGPoint(x: .zero, y: skView.bounds.size.height)
        #endif
        return bottomY
    }
}
