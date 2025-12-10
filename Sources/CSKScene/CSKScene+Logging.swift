import AppLogger
import Foundation

/// `CSKScene` logging categories to further distinguish the running parts of the package.
///
/// Refer to: https://developer.apple.com/documentation/os/logging
public enum CSKSceneLoggingCategory: String {
    case error          = "CSKScene_Error"
    case sklifecycle    = "CSKScene_SpriteKitLifecycle"
}

// MARK: - Interface

public extension CSKScene {

    // MARK: Enable / Disable Logging

    /// Enables logging information via `AppLogger`.
    ///
    /// When logging is enabled, the output will be available in *Xcode's Console* or
    /// in the *macOS Console app*.
    ///
    /// In the **macOS Console app**, you can filter CSKScene's output by
    /// `SUBSYSTEM`: `com.thatfactory.CSKScene`.
    func enableLogging() {
        CSKScene.isLoggingEnabled = true
    }

    /// Disables logging information via `AppLogger`.
    func disableLogging() {
        CSKScene.isLoggingEnabled = false
    }
}

// MARK: - Internal

internal extension CSKScene {

    /// Logs the given `String` information via `AppLogger`.
    ///
    /// - Parameters:
    ///   - information: The `String` to be logged.
    ///   - category: A member of the `CSKSceneLoggingCategory` enum.
    static func log(information: String, category: CSKSceneLoggingCategory) {
        guard isLoggingEnabled else {
            return
        }
        let subsystem = "com.thatfactory.CSKScene"
        let logger = AppLogger(subsystem: subsystem, category: category.rawValue)
        logger.log(information)
    }

    static func logError(_ error: String) {
        log(information: error, category: .error)
    }
}
