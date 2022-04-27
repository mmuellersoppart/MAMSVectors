//
//  File.swift
//  
//
//  Created by Marlon Mueller Soppart on 4/2/22.
//

import XCTest
@testable import MAMSVectors

final class Point2DTests: XCTestCase {
    func testAddition() throws {
        let pt1 = Point2D(x: 1.0, y: 2.0)
        let pt2 = Point2D(x: 1.0, y: 2.0)

        let expected = Point2D(x: 2.0, y: 4.0)
        let actual = pt1 + pt2

        XCTAssertEqual(expected, actual)
    }

    func testDistance() throws  {
        let pt1 = Point2D(x: .zero, y: .zero)
        let pt2 = Point2D(x: 4, y: 5)

        let expected = sqrt(16.0 + 25.0)
        let actual = pt1.distance(to: pt2)

        XCTAssertEqual(expected, actual)
    }

    func testDistanceNoDistance() throws {
        let pt1 = Point2D(x: .zero, y: .zero)
        let pt2 = Point2D(x: .zero, y: .zero)

        let expected = 0.0
        let actual = pt1.distance(to: pt2)

        XCTAssertEqual(expected, actual)
    }

    func testCopy() throws {
        let pt = Point2D(x: 1.0, y: 2.0)

        let ptCopy = pt.copy()

        XCTAssertEqual(pt, ptCopy)

        let ptXAdjusted = pt.copy(x: 4.0)

        XCTAssertEqual(pt.y, ptXAdjusted.y)
        XCTAssertNotEqual(pt.x, ptXAdjusted.x)
        XCTAssertEqual(4.0, ptXAdjusted.x)
    }
}

