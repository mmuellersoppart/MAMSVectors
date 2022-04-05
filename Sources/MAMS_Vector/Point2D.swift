//
//  File.swift
//  
//
//  Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation
import CoreGraphics

public struct Point2D {
    public let x: Double
    public let y: Double

    public var asCGPoint: CGPoint {
        CGPoint(x: x, y: y)
    }
}

extension Point2D {
    func distance(to point: Point2D) -> Double {
        let xDist = point.x - x
        let yDist = point.y - y
        
        return (xDist * xDist) + (yDist * yDist)
    }
}

// operators

extension Point2D : Equatable {
    public static func +(lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y) 
    }
}

extension Point2D {
    public static func == (lhs: Point2D, rhs: Point2D) -> Bool {
        (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
}

extension CGPoint {
    public var asPoint2D: Point2D {
        Point2D(x: x, y: y)
    }
}