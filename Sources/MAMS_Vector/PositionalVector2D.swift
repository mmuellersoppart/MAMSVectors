//
// Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation

public struct PositionalVector2D {
    let origin: Point2D
    let vector: Vector2D

    var tip: Point2D {
        Point2D(x: origin.x + vector.x, y: origin.y + vector.y)
    }
}


extension PositionalVector2D : Equatable {
    public static func ==(lhs: PositionalVector2D, rhs: PositionalVector2D) -> Bool {
        (lhs.origin == rhs.origin) && (rhs.vector == lhs.vector)
    }
}


extension PositionalVector2D {

    /// Find when the position vector intercepts the given x value
    /// - Parameter xTarget: x value in a cartesian plane
    func intercept(x xTarget: Double) -> Point2D? {

        // determine distance from vector start to x
        let distance = xTarget - origin.x

        let scaleToX = distance / vector.x

        // make sure the vector hits the target
        guard scaleToX >= .zero else { return nil }

        return Point2D(x: xTarget, y: origin.y + (scaleToX * vector.y))
    }

    func intercept(y yTarget: Double) -> Point2D? {
        
        // determine distance from vector start to target
        let distance = yTarget - origin.y
        
        // how much the vector needs to be scaled to reach target
        let scaleToY = distance / vector.y
        
        // make sure
        guard scaleToY >= .zero else { return nil }
        
        return Point2D(x: origin.x + (scaleToY * vector.x), y: yTarget)
    }
}

extension PositionalVector2D {
    init(point: Point2D, vector: Vector2D) {
        self.vector = vector
        origin = point
    }
}
