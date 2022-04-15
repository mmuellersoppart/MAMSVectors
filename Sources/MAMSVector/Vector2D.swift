//
// Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation
import CoreGraphics

/// A 2-dimensional vector (CGVector)
public struct Vector2D {
    public var x: Double
    public var y: Double

    // computed property
    public var asCGVector: CGVector {
        CGVector(dx: x, dy: y)
    }
    public var magnitude: Double {
        get {
            Point2D(x: .zero, y: .zero).distance(to: Point2D(x: x, y: y))
        }
        set(newMagnitude) {

            let newVector = self.copy(magnitude: newMagnitude)

            x = newVector.x
            y = newVector.y
        }
    }

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

// operator

extension Vector2D : Equatable {
    public static func == (lhs: Vector2D, rhs: Vector2D) -> Bool {
        (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
}

extension Vector2D {
    public static func +(lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

// function
extension Vector2D {
    public func copy(x: Double?, y: Double?) -> Vector2D {

        var newX = self.x
        var newY = self.y

        if let x = x { newX = x }
        if let y = y { newY = y }

        return Vector2D(x: newX, y: newY)
    }

    public func copy(magnitude: Double) -> Vector2D {

        let ratioXoverY: Double = x/y  // this can substitute a y value (ratio * y)^2 + (y)^2
        let addOtherY: Double = pow(ratioXoverY, 2) + 1  // add lhs ((ratio)^2 * y^2) + y^2 -> ((ratio)^2 + 1) y^2

        let applySqrt: Double = sqrt(addOtherY)

        let newY: Double = (1/applySqrt) * magnitude
        let newX: Double = ratioXoverY * newY

        return Vector2D(x: newX, y: newY)
    }
}

extension CGVector {
    public var asVector2D: Vector2D {
        Vector2D(x: dx, y: dy)
    }
}
