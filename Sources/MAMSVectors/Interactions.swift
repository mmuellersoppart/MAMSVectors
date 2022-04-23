/*
 How these vector types interact with types beyond themselves
 */

import SwiftUI

/// Translate a point by a vector.
public func +(left: Point2D, right: Vector2D) -> Point2D {
    Point2D(x: left.x + right.x, y: left.y + right.y)
}

/// Translate a point by a vector.
public func +(left: Vector2D, right: Point2D) -> Point2D {
    Point2D(x: left.x + right.x, y: left.y + right.y)
}

/// Multiply a Positional Vector by a scalar.
public func *(left: Double, right: PositionalVector2D) -> PositionalVector2D {
    PositionalVector2D(originX: right.origin.x, originY: right.origin.y, vectorX: right.vector.x * left, vectorY: right.vector.y * left)
}

/// Multiply a Vector by a scalar
public func *(left: Double, right: Vector2D) -> Vector2D {
    Vector2D(x: right.x * left, y: right.y * left)
}

// Convenience function
@available(iOS 15.0, *)
@available(macOS 15.0, *)
extension Collection where Element: Drawable {
    /// Draw all the ``Drawable`` elements in a collection
    public func draw(context: inout GraphicsContext) {
        for e in self {
            e.draw(context: &context)
        }
    }
}
