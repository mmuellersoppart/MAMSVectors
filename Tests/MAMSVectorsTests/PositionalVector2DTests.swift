//
//  File.swift
//  
//
//  Created by Marlon Mueller Soppart on 4/2/22.
//

import XCTest
@testable import MAMSVectors

final class PositionalVector2DTests: XCTestCase {
    func testAddition() throws {
       
        let pt = Point2D(x: 1.0, y: 2.0)
        let vec = Vector2D(x: 0.5, y: -3.0)
        
        let expected = PositionalVector2D(point: Point2D(x: 1.0, y: 2.0), vector: Vector2D(x: 0.5, y: -3.0))
        let actual = PositionalVector2D(point: pt, vector: vec)
        
        XCTAssertEqual(expected, actual)
    }
    
    func testInterceptX() throws {
        
        // test successful intersection from 0
        let vec = PositionalVector2D(origin: Point2D(x: .zero, y: .zero), vector: Vector2D(x: 2.0, y: 5.0))
        
        let expectedIntersection = Point2D(x: 10.0, y: 25.0)
        let actualIntersection = vec.intercept(x: 10.0)
        
        XCTAssertEqual(expectedIntersection, actualIntersection)
    }
    
    func testInterceptYNonZero() throws {
        
        // test successful intersection from non zero origin
        let vec = PositionalVector2D(origin: Point2D(x: -6.0, y: 5.5), vector: Vector2D(x: 4.0, y: -3))
        
        let expectedIntersection = Point2D(x: 28.0, y: -20.0)
        let actualIntersection = vec.intercept(y: -20)
        
        XCTAssertEqual(expectedIntersection, actualIntersection)
    }
    
    func testInterceptXFail() throws {
        let vec = PositionalVector2D(origin: Point2D(x: .zero, y: .zero), vector: Vector2D(x: -2.0, y: 5.0))
        
        let expectedIntersection: Point2D? = nil
        let actualIntersection = vec.intercept(x: 10.0)
        
        XCTAssertEqual(expectedIntersection, actualIntersection)
    }
}


