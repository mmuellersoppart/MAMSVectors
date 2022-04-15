import XCTest
@testable import MAMSVector

final class MAMSVectorTests: XCTestCase {
    func testAdditionPointAndVector() throws {
        let pt = Point2D(x: 1.0, y: 2.0)
        let vec = Vector2D(x: 1.0, y: 2.0)
        
        let expected = Point2D(x: 2.0, y: 4.0)
        let actual = pt + vec
        
        XCTAssertEqual(expected, actual)
        
        let actual2 = vec + pt
        
        XCTAssertEqual(expected, actual2)
    }
}
