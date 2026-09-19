public import Foundation
import SpriteKit

extension CSKScene {
    /// The "highest `SKScene` point" converted from the "highest `SKView` point".
    public var viewTop: CGFloat {
        guard let skView = view else {
            return .zero
        }
        return convertPoint(fromView: highestScenePoint(in: skView)).y
    }

    /// The "lowest `SKScene` point" converted from the "lowest`SKView` point".
    public var viewBottom: CGFloat {
        guard let skView = view else {
            return .zero
        }
        return convertPoint(fromView: lowestScenePoint(in: skView)).y
    }

    /// The "leftmost `SKScene` point" converted from the "leftmost`SKView` point".
    public var viewLeft: CGFloat {
        convertPoint(fromView: .zero).x
    }

    /// The "rightmost `SKScene` point" converted from the "rightmost`SKView` point".
    public var viewRight: CGFloat {
        guard let view = view else {
            return .zero
        }
        let point = CGPoint(x: view.bounds.size.width, y: .zero)
        return convertPoint(fromView: point).x
    }
}

// MARK: - Private

extension SKScene {
    // MARK: Coordinate System

    // macOS uses a different coordinate system. These functions handle that.
    // The #else fallback defaults to iOS-style coordinates and asserts to surface
    // unsupported platforms during development.

    fileprivate func highestScenePoint(in skView: SKView) -> CGPoint {
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

    fileprivate func lowestScenePoint(in skView: SKView) -> CGPoint {
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
