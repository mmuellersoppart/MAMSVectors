//
// Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation
import CoreGraphics
import SwiftUI

/// A Vector2D that can be placed in a cartesian plane
public struct PositionalVector2D: Drawable {

    /// Where the vector starts
    public var origin: Point2D

    /// The vector itself
    public var vector: Vector2D

    /// origin + vector
    public var tip: Point2D {
        Point2D(x: origin.x + vector.x, y: origin.y + vector.y)
    }

    /// returns a vector perpendicular to the original with the same base
    public var perpendicular: PositionalVector2D {
        PositionalVector2D(originX: origin.x, originY: origin.y, vectorX: -vector.y, vectorY: vector.x)
    }

    /// how long the vector is. This can be set but this changes the x and y value of the vector.
    public var magnitude: Double {
        get {
            vector.magnitude
        }
        set(newMagnitude) {
            vector.magnitude = newMagnitude
        }
    }

}

extension PositionalVector2D {
    public init(originX: Double, originY: Double, vectorX: Double, vectorY: Double) {
        origin = Point2D(x: originX, y: originY)
        vector = Vector2D(x: vectorX, y: vectorY)
    }

    public init(point: Point2D, vector: Vector2D) {
        origin = point
        self.vector = vector
    }
    
    public init(start: Point2D, end: Point2D) {
        origin = start
        vector = Vector2D(x: end.x - start.x, y: end.y - start.y)
    }
}

extension PositionalVector2D : Equatable {
    public static func ==(lhs: PositionalVector2D, rhs: PositionalVector2D) -> Bool {
        (lhs.origin == rhs.origin) && (rhs.vector == lhs.vector)
    }
}


// Connection to Core Graphics
@available(iOS 15.0, *)
@available(macOS 15.0, *)
extension PositionalVector2D {
    public func asPath(withArrowHead: Bool = true) -> Path {
        Path { path in
            path.move(to: origin.asCGPoint)
            
            // draw point
            path = origin.asPath(pointDiameter: 3)
            path.addPath(path)
            path.move(to: origin.asCGPoint)
            
            // draw trunk of vector
            path.addLine(to: tip.asCGPoint)
            
            // maybe draw arrow head
            if withArrowHead{
                let arrowHeadPath = self.arrowHeadPath()
                path.addPath(arrowHeadPath)
            }
        }
    }

    public func draw(context: inout GraphicsContext) {
        let positionalVector2DPath = asPath()
        context.stroke(positionalVector2DPath, with: .color(.red))
    }
    
    internal func arrowHeadPath() -> Path {
        return Path { path in
            let headBase = (0.9 * self).tip

            var miniPerp = 0.05 * self.perpendicular
            miniPerp.origin = headBase
            
            // draw the lines
            path.move(to: miniPerp.tip.asCGPoint)
            path.addLine(to: self.tip.asCGPoint)
            
            miniPerp = -1.0 * miniPerp
            path.move(to: miniPerp.tip.asCGPoint)
            path.addLine(to: self.tip.asCGPoint)
        }
    }
}

extension PositionalVector2D {


    /// Made for more functional style of programming.
    /// - Parameter magnitude: How long we want the vector to be.
    /// - Returns: A new PositionalVector with the specified magnitude but the x and y vector have
    /// the same starting ratio.
    public func copy(magnitude: Double) -> PositionalVector2D {
        let origin = origin
        let vector = vector.copy(magnitude: magnitude)
        return PositionalVector2D(origin: origin, vector: vector)
    }

    /// Made for more functional style of programming. Rotates the vector.
    ///
    /// $$x_2 = \cos{\beta x_1} - \sin{\beta y_1} \newline y_2 = \sin{\beta x_1} + \cos{\beta y_1}$$
    ///
    /// - Parameter radians: How much rotation should take place. 0 - 2π is one full rotation
    /// - Returns: A new PositionalVector where the magnitude is the same but it's rotated
    public func copy(radians: Double) -> PositionalVector2D {
        let newX: Double = vector.x * cos(radians) - vector.y * sin(radians)
        let newY: Double = vector.x * sin(radians) + vector.y * cos(radians)

        return PositionalVector2D(origin: Point2D(x: origin.x, y: origin.y), vector: Vector2D(x: newX, y: newY))
    }

    /// Made for more functional style of programming.
    /// - Parameters:
    ///   - originX: adjust the x value of the origin
    ///   - originY: adjust the y value of the origin
    ///   - vectorX: adjust the x value of the vector
    ///   - vectorY: adjust the y value fo the vector
    /// - Returns:
    ///    - Return: a new positional vector based on the original with any desired adjustments
    public func copy(originX: Double? = nil, originY: Double? = nil, vectorX: Double? = nil, vectorY: Double? = nil) -> PositionalVector2D {
        var newOriginX = origin.x
        var newOriginY = origin.y

        if let originX = originX { newOriginX = originX }
        if let originY = originY { newOriginY = originY }

        var newVectorX = vector.x
        var newVectorY = vector.y

        if let vectorX = vectorX { newVectorX = vectorX }
        if let vectorY = vectorY { newVectorY = vectorY }

        return PositionalVector2D(originX: newOriginX, originY: newOriginY, vectorX: newVectorX, vectorY: newVectorY)
    }

    /// Find when the position vector intercepts the given x value. It does not check in the negative direction.
    /// - Parameter xTarget: x value in a cartesian plane
    /// - Returns: ``Point2D``, where the vector intercepts the inputted x value.
    public func intercept(x xTarget: Double) -> Point2D? {

        // determine distance from vector start to x
        let distance = xTarget - origin.x

        let scaleToX = distance / vector.x

        // make sure the vector hits the target
        guard scaleToX >= .zero else { return nil }

        return Point2D(x: xTarget, y: origin.y + (scaleToX * vector.y))
    }

    /// Find when the position vector intercepts the given y value. It does not check in the negative direction.
    /// - Parameter yTarget: y value in a cartesian plane
    /// - Returns: ``Point2D``, where the vector intercepts the inputted y value.
    public func intercept(y yTarget: Double) -> Point2D? {
        
        // determine distance from vector start to target
        let distance = yTarget - origin.y
        
        // how much the vector needs to be scaled to reach target
        let scaleToY = distance / vector.y
        
        // make sure
        guard scaleToY >= .zero else { return nil }
        
        return Point2D(x: origin.x + (scaleToY * vector.x), y: yTarget)
    }
}
