import GameplayKit

import class Foundation.Bundle

extension CSKScene {
    /// Loads the `GKScene`'s root node and returns it as `CSKScene`.
    ///
    /// Notice: the class name must match the filename.
    /// E.g.: for a class named `StartScene`, the function tries to load a file named `StartScene.sks`.
    ///
    /// - Returns: The root node of a `GKScene` as a `CSKScene` instance.
    public static func makeScene<T: CSKScene>() -> T {
        let filename = String(describing: self)

        // Load a GKScene object from a SKS file.
        guard let gkScene = GKScene(fileNamed: filename) else {
            let errorMessage = "Could not load \"\(filename).sks\" as a \"GKScene\" object"
            CSKScene.logError(errorMessage)
            fatalError(errorMessage)
        }

        // Load the GKScene's root node as a CSKScene.
        guard let cskScene = gkScene.rootNode as? T else {
            let errorMessage = "Could not load the \"GKScene's root node\" as a \"CSKScene\""
            CSKScene.logError(errorMessage)
            fatalError(errorMessage)
        }

        return cskScene
    }
}
