import Foundation

public struct DebugSettings {
    let disableAll: Bool
    let showsFPS: Bool
    let showsFields: Bool
    let showsPhysics: Bool
    let showsDrawCount: Bool
    let showsNodeCount: Bool
    let showsQuadCount: Bool

    /// By default, all debugging options are shown (`true`) in `DEBUG` mode.
    /// To disable all of them at once, set `disableAll` to `true`
    public init(
        disableAll: Bool = false, showsFPS: Bool = true, showsFields: Bool = true,
        showsPhysics: Bool = true, showsDrawCount: Bool = true, showsNodeCount: Bool = true,
        showsQuadCount: Bool = true
    ) {
        self.disableAll = disableAll
        self.showsFPS = disableAll ? false : showsFPS
        self.showsFields = disableAll ? false : showsFields
        self.showsPhysics = disableAll ? false : showsPhysics
        self.showsDrawCount = disableAll ? false : showsDrawCount
        self.showsNodeCount = disableAll ? false : showsNodeCount
        self.showsQuadCount = disableAll ? false : showsQuadCount
    }
}
