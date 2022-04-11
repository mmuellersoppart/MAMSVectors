//
// Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation
import CoreGraphics

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

            let ratioXoverY: Double = x/y  // this can substitute a y value (ratio * y)^2 + (y)^2
            let addOtherY: Double = pow(ratioXoverY, 2) + 1  // add lhs ((ratio)^2 * y^2) + y^2 -> ((ratio)^2 + 1) y^2

            let applySqrt: Double = sqrt(addOtherY)

            let yEquals: Double = (1/applySqrt) * newMagnitude
            let xEquals: Double = ratioXoverY * yEquals

            x = xEquals
            y = yEquals
        }
    }

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}


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

extension CGVector {
    public var asVector2D: Vector2D {
        Vector2D(x: dx, y: dy)
    }
}