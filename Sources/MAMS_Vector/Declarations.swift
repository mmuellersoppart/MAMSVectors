public struct Vector2D {
    let x: Double
    let y: Double
}

public struct Point2D {
    let x: Double
    let y: Double
}

public struct PositionalVector2D {
    let origin: Point2D
    let vector: Vector2D
}

extension PositionalVector2D {
    init(point: Point2D, vector: Vector2D) {
        self.vector = vector
        origin = point
    }
}

func +(left: Point2D, right: Vector2D) -> Point2D {
    Point2D(x: left.x + right.x, y: left.y + right.y)
}

func +(left: Vector2D, right: Point2D) -> Point2D {
    Point2D(x: left.x + right.x, y: left.y + right.y)
}
