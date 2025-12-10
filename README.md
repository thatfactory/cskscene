[![swift-version](https://img.shields.io/badge/swift-6.2-ea7a50.svg?logo=swift&logoColor=white)](https://developer.apple.com/swift/)
[![xcode-version](https://img.shields.io/badge/xcode-26.2-50ace8.svg?logo=xcode&logoColor=white)](https://developer.apple.com/xcode/)
[![spm-ready](https://img.shields.io/badge/spm-ready-b68f6a.svg?logo=gitlfs&logoColor=white)](https://developer.apple.com/documentation/xcode/swift-packages)
[![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20iPadOS%20%7C%20macOS%20%7C%20Mac%20Catalyst%20%7C%20tvOS-lightgrey.svg?logo=apple&logoColor=white)](https://en.wikipedia.org/wiki/List_of_Apple_operating_systems)
[![license](https://img.shields.io/badge/license-MIT-67ac5b.svg?logo=googledocs&logoColor=white)](https://en.wikipedia.org/wiki/MIT_License)
[![release](https://github.com/thatfactory/cskscene/actions/workflows/release.yml/badge.svg)](https://github.com/thatfactory/cskscene/actions/workflows/release.yml)

# CSKScene 🌃
A **custom** [`SKScene`](https://developer.apple.com/documentation/spritekit/skscene) subclass with debug options enabled by default and the ability to observe game controllers via [`GCOverseer`](https://github.com/thatfactory/gcoverseer).

## Usage Examples
Subclass `CSKScene` to have access to its properties:
```swift
class MyScene: CSKScene { ... }
```

### Debug Settings
All debug settings are enable by default (in `DEBUG` mode):

 - `showsFPS`
 - `showsFields`
 - `showsPhysics`
 - `showsDrawCount`
 - `showsNodeCount`
 - `showsQuadCount`

To disable **all** options at once:
```swift
let debugSettings = DebugSettings(disableAll: true)
let myScene = CSKScene(size: someSize, debugSettings: debugSettings)
```

To disable **some** options:
```swift
let debugSettings = DebugSettings(showsFPS: false, showsPhysics: false, showsNodeCount: false)
let myScene = CSKScene(size: someSize, debugSettings: debugSettings)
```

It's also possible to change debug settings after initialization:
```swift
let myScene = CSKScene(size: someSize) // All debug settings are enabled by default...
myScene.debugSettings = DebugSettings(showsFields: false, showsQuadCount: false) // ... but these will be disabled
```

### Observe Game Controllers
`sink` into the `gcOverseer` to keep track of connect / disconnect events of game controllers. E.g.:

```swift
class MyScene: CSKScene {
    func observeGameControllers() {
        gcOverseer.$isGameControllerConnected // `gcOverseer` from parent `CSKScene`
            .sink { isConnected in
                // Do something
            }
            .store(in: &cancellables) // `cancellables` from parent `CSKScene`
    }
}
```

## Available Properties
Property | Description | Notes
-------- | ----------- | -----
`var viewTop: CGFloat`| The "highest `SKScene` point" converted from the "highest `SKView` point". | -
`var viewBottom: CGFloat`| The "lowest `SKScene` point" converted from the "lowest`SKView` point". | -
`var viewLeft: CGFloat`| The "leftmost `SKScene` point" converted from the "leftmost`SKView` point". | -
`var viewRight: CGFloat`| The "rightmost `SKScene` point" converted from the "rightmost`SKView` point". | -

## Default Values
These properties have the following default values:

Property name | Default value | Notes
--- | --- | ---
[ignoresSiblingOrder](https://developer.apple.com/documentation/spritekit/skview/1520215-ignoressiblingorder) | `true` | Prevents arbitrary z positions that may change every time a new frame is rendered.
[isMultipleTouchEnabled](https://developer.apple.com/documentation/uikit/uiview/1622519-ismultipletouchenabled) | `true` | Surprinsingly this had to be set to `true` to support multiple touches when working with [SceneView](https://developer.apple.com/documentation/scenekit/sceneview) / SwiftUI.

To set then to `false`, override `CSKScene.didMove(to:)` in your subclass. For example:
```swift
class MyScene: CSKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        view.ignoresSiblingOrder = false
        view.isMultipleTouchEnabled = false
    }
}
```
# CSKNode
A **custom** [`SKNode`](https://developer.apple.com/documentation/spritekit/sknode) subclass that provides observable properties based on `KVO` + `Combine`.

## Usage Examples
Subscribe to `didAttachToParent` to get informed whenever the node is attached to or detached from a parent node.

```swift
class MyNode: CSKNode {

    override init() {
        super.init()
        sinkOnParentChanges()
    }

    func sinkOnParentChanges() {
        $didAttachToParent // `didAttachToParent` from parent `CSKNode`
            .sink { [weak self] isAttachedToParent in
                if isAttachedToParent {
                    // Setup your node 👈🏻
                }
            }
            .store(in: &cancellables) // `cancellables` from parent `CSKNode`
    }
}
```

## Integration
### Xcode
Use Xcode's [built-in support for SPM](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

*or...*

### Package.swift
In your `Package.swift`, add `CSKScene` as a dependency:
```swift
dependencies: [
    .package(
        url: "https://github.com/thatfactory/cskscene",
        from: "0.1.0"
    )
]
```

Associate the dependency with your target:
```swift
    .target(
        name: "YourTarget",
        dependencies: [
            .product(
                name: "CSKScene",
                package: "cskscene"
            )
        ]
    )
]
```

Run: `swift build`

