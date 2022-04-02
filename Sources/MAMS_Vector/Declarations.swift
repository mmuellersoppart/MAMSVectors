public struct Vector2D {
    let x: Double
    let y: Double
}

public struct Point2D {
    let x: Double
    let y: Double
}

public struct PositionalVector2D {
    let vector: Vector2D
    let origin: Point2D
}

extension PositionalVector2D {
    
    init(point: Point2D, vector: Vector2D) {
        self.vector = vector
        self.origin = point
    }
    /// Find when a position vector intercepts a certain x value
    /// - Parameter x: x value in a cartesian plane
//    func intercept(x: Double) -> Point2D? {
//        x - (self.origin + self.vector).x
//
//    }
}

func +(left: Point2D, right: Vector2D) -> Point2D {
    return Point2D(x: left.x + right.x, y: left.y + right.y)
}

func +(left: Vector2D, right: Point2D) -> Point2D {
    return Point2D(x: left.x + right.x, y: left.y + right.y)
}
