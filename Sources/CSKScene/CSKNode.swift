import Combine
import SpriteKit

/// A `SKNode` subclass that provides observable properties based on `KVO`.
open class CSKNode: SKNode, ObservableObject {
    // MARK: Public Properties
    /// Subscribe to this variable to get informed whenever this node is attached to or detached from a parent node.
    ///
    /// If the node is not in a node tree, the value is `false`.
    @Published public private(set) var didAttachToParent = false

    public var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    override public init() {
        super.init()
        observeParent()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        observeParent()
    }
}

// MARK: - Private

extension CSKNode {
    /// Uses `KVO` / `KeyValueObservingPublisher` to observe `self.parent` and updates
    /// `CSKNode.getter:didAttachToParent` accordingly.
    fileprivate func observeParent() {
        publisher(for: \.parent)
            .sink(receiveValue: { [weak self] _ in
                self?.didAttachToParent = (self?.parent != nil)
            })
            .store(in: &cancellables)
    }
}
