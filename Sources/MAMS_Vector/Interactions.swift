public func +(left: Point2D, right: Vector2D) -> Point2D {
    Point2D(x: left.x + right.x, y: left.y + right.y)
}

public func +(left: Vector2D, right: Point2D) -> Point2D {
    Point2D(x: left.x + right.x, y: left.y + right.y)
}

public func *(left: Double, right: PositionalVector2D) -> PositionalVector2D {
    PositionalVector2D(originX: right.origin.x, originY: right.origin.y, vectorX: right.vector.x * left, vectorY: right.vector.y * left)
}

// TODO: add multiplication for just vector