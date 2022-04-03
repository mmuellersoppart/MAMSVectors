func +(left: Point2D, right: Vector2D) -> Point2D {
    Point2D(x: left.x + right.x, y: left.y + right.y)
}

func +(left: Vector2D, right: Point2D) -> Point2D {
    Point2D(x: left.x + right.x, y: left.y + right.y)
}
