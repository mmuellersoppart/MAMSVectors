//
// Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation


public struct PositionalVector2D {
    public var origin: Point2D
    public var vector: Vector2D

    public var tip: Point2D {
        Point2D(x: origin.x + vector.x, y: origin.y + vector.y)
    }

    public var perpendicular: PositionalVector2D {
        PositionalVector2D(originX: origin.x, originY: origin.y, vectorX: vector.y, vectorY: vector.x)
    }

    //TODO: add getter and setter for magnitude
    public var magnitude: Double {
        get {
            vector.magnitude
        }
        set(newMagnitude) {
            vector.magnitude = newMagnitude
        }
    }

}

// initializers
extension PositionalVector2D {
    public init(originX: Double, originY: Double, vectorX: Double, vectorY: Double) {
        origin = Point2D(x: originX, y: originY)
        vector = Vector2D(x: vectorX, y: vectorY)
    }

    public init(point: Point2D, vector: Vector2D) {
        origin = point
        self.vector = vector
    }
}

// Operators, only PositionalVectors
extension PositionalVector2D : Equatable {
    public static func ==(lhs: PositionalVector2D, rhs: PositionalVector2D) -> Bool {
        (lhs.origin == rhs.origin) && (rhs.vector == lhs.vector)
    }
}


// Functions
extension PositionalVector2D {

    //TODO: Add functional for changing magnitude, point, origin, and elements within them
    //Copy function with variable args
    public func copy(magnitude: Double) -> PositionalVector2D {
        let origin = origin
        let vector = vector.copy(magnitude: magnitude)
        return PositionalVector2D(origin: origin, vector: vector)
    }

    /// Find when the position vector intercepts the given x value
    /// - Parameter xTarget: x value in a cartesian plane
    public func intercept(x xTarget: Double) -> Point2D? {

        // determine distance from vector start to x
        let distance = xTarget - origin.x

        let scaleToX = distance / vector.x

        // make sure the vector hits the target
        guard scaleToX >= .zero else { return nil }

        return Point2D(x: xTarget, y: origin.y + (scaleToX * vector.y))
    }

    public func intercept(y yTarget: Double) -> Point2D? {
        
        // determine distance from vector start to target
        let distance = yTarget - origin.y
        
        // how much the vector needs to be scaled to reach target
        let scaleToY = distance / vector.y
        
        // make sure
        guard scaleToY >= .zero else { return nil }
        
        return Point2D(x: origin.x + (scaleToY * vector.x), y: yTarget)
    }
}
