//
//  File.swift
//  
//
//  Created by Marlon Mueller Soppart on 4/2/22.
//

import XCTest
@testable import MAMS_Vector

final class PositionalVector2DTests: XCTestCase {
    func testAddition() throws {
       
            let pt = Point2D(x: 1.0, y: 2.0)
            let vec = Vector2D(x: 0.5, y: -3.0)
            
            let expected = PositionalVector2D(point: Point2D(x: 1.0, y: 2.0), vector: Vector2D(x: 0.5, y: -3.0))
            let actual = PositionalVector2D(point: pt, vector: vec)
            
            XCTAssertEqual(expected, actual)
        }
}


