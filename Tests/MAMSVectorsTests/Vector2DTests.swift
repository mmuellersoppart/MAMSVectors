//
//  File.swift
//
//
//  Created by Marlon Mueller Soppart on 4/2/22.
//

import XCTest
@testable import MAMSVectors

final class Vector2DTests: XCTestCase {
    func testMagnitude() throws {
        let vec = Vector2D(x: 4, y: 4)
        let actual = vec.magnitude
        let expected = Point2D(x: .zero, y: .zero).distance(to: Point2D(x: 4, y: 4))

        XCTAssertEqual(expected, actual)
    }

    func testSetMagnitude() throws {
        var vec = Vector2D(x: 4, y: 4)
        vec.magnitude = 1
        let actualX = vec.x
        let actualY = vec.y

        let expectedXAndY = sqrt(0.5)

        XCTAssertTrue(actualX.isEqual(to: expectedXAndY, precision: 4), "expected \(expectedXAndY) and got x: \(actualX) and y: \(actualY)")
        XCTAssertTrue(actualY.isEqual(to: expectedXAndY, precision: 4))

        XCTAssertTrue(vec.magnitude.isEqual(to: 1.0, precision: 6))
    }

    func testSetMagnitudeNegativeVector() throws {
        var vec = Vector2D(x: -4, y: -4)
        vec.magnitude = 1
        let actualX = vec.x
        let actualY = vec.y

        let expectedXAndY = -sqrt(0.5)

        XCTAssertTrue(actualX.isEqual(to: expectedXAndY, precision: 4), "expected \(expectedXAndY) and got x: \(actualX) and y: \(actualY)")
        XCTAssertTrue(actualY.isEqual(to: expectedXAndY, precision: 4))

        XCTAssertTrue(vec.magnitude.isEqual(to: 1.0, precision: 6))
    }
    
    func testSetMagnitudeNegativeMagnitude() throws {
        var vec = Vector2D(x: 4, y: 4)
        vec.magnitude = -1
        let actualX = vec.x
        let actualY = vec.y

        let expectedXAndY = -sqrt(0.5)

        XCTAssertTrue(actualX.isEqual(to: expectedXAndY, precision: 4), "expected \(expectedXAndY) and got x: \(actualX) and y: \(actualY)")
        XCTAssertTrue(actualY.isEqual(to: expectedXAndY, precision: 4))

        XCTAssertTrue(vec.magnitude.isEqual(to: 1.0, precision: 6))
    }

}

extension Double {
    func isEqual(to other: Double, precision: Int) -> Bool {
        let error: Double = 1.0 * pow(10.0, -Double(precision))

        return abs( (self - other) ) < error
    }
}
