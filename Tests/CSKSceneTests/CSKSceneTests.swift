import XCTest
@testable import CSKScene

@MainActor final class CSKSceneTests: XCTestCase {

    func testAllDebugOptionsAreEnabledByDefault() {
        let cskscene = CSKScene(size: .zero)
        XCTAssertTrue(cskscene.debugSettings.showsFPS)
        XCTAssertTrue(cskscene.debugSettings.showsFields)
        XCTAssertTrue(cskscene.debugSettings.showsPhysics)
        XCTAssertTrue(cskscene.debugSettings.showsDrawCount)
        XCTAssertTrue(cskscene.debugSettings.showsNodeCount)
        XCTAssertTrue(cskscene.debugSettings.showsQuadCount)
    }

    func testDebugOptionsAreDisabled() {
        let debugSettings = DebugSettings(disableAll: true)
        let cskscene = CSKScene(size: .zero, debugSettings: debugSettings)
        XCTAssertFalse(cskscene.debugSettings.showsFPS)
        XCTAssertFalse(cskscene.debugSettings.showsFields)
        XCTAssertFalse(cskscene.debugSettings.showsPhysics)
        XCTAssertFalse(cskscene.debugSettings.showsDrawCount)
        XCTAssertFalse(cskscene.debugSettings.showsNodeCount)
        XCTAssertFalse(cskscene.debugSettings.showsQuadCount)
    }

    func testSomeDebugOptionsAreDisabled() {
        let debugSettings = DebugSettings(showsFPS: false, showsPhysics: false, showsNodeCount: false)
        let cskscene = CSKScene(size: .zero, debugSettings: debugSettings)
        XCTAssertFalse(cskscene.debugSettings.showsFPS)
        XCTAssertFalse(cskscene.debugSettings.showsPhysics)
        XCTAssertFalse(cskscene.debugSettings.showsNodeCount)
        XCTAssertTrue(cskscene.debugSettings.showsFields)
        XCTAssertTrue(cskscene.debugSettings.showsDrawCount)
        XCTAssertTrue(cskscene.debugSettings.showsQuadCount)
    }

    func testGCOverseerIsValid() {
        let cskscene = CSKScene(size: .zero)
        XCTAssertNotNil(cskscene.gcOverseer)
        XCTAssertTrue(cskscene.gcOverseer.controllers.isEmpty)
    }
}
