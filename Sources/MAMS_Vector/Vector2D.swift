//
// Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation
import CoreGraphics

public struct Vector2D {
    public let x: Double
    public let y: Double

    public var asCGVector: CGVector {
        CGVector(dx: x, dy: y)
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