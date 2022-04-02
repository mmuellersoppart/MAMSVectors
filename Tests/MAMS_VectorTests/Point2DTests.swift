//
//  File.swift
//  
//
//  Created by Marlon Mueller Soppart on 4/2/22.
//

import XCTest
@testable import MAMS_Vector

final class Point2DTests: XCTestCase {
    func testAddition() throws {
       
            let pt1 = Point2D(x: 1.0, y: 2.0)
            let pt2 = Point2D(x: 1.0, y: 2.0)
            
            let expected = Point2D(x: 2.0, y: 4.0)
            let actual = pt1 + pt2
            
            XCTAssertEqual(expected, actual)
        }
}

