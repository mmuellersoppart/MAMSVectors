//
// Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation


extension PositionalVector2D : Equatable {
    public static func ==(lhs: PositionalVector2D, rhs: PositionalVector2D) -> Bool {
        (lhs.origin == rhs.origin) && (rhs.vector == lhs.vector)
    }
}


extension PositionalVector2D {

    /// Find when the position vector intercepts the given x value
    /// - Parameter xTarget: x value in a cartesian plane
    func intercept(x xTarget: Double) -> Point2D? {

        // determine distance from origin to x
        let distance = xTarget - origin.x

        let scaleToX = distance / vector.x

        // make sure the vector will ever hit the x value
        guard scaleToX >= .zero else { return nil }

        return Point2D(x: xTarget, y: origin.y + (scaleToX * vector.y))
    }

    func intercept(y yTarget: Double) -> Point2D? {

    }
}
