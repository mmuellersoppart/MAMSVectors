//
// Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation
import CoreGraphics
import SwiftUI

/**
A 2-dimensional vector (CGVector).
 
Example of use
```swift
 import SwiftUI
 import MAMSVectors
 
 struct Vector2DExample: View {
     let scale: Double = 0.6
     
     var body: some View {
         ZStack {
             Canvas { context, size in
                 
                 let centerPoint = Point2D(x: size.width / 2, y: size.height / 2)
                 
                 // vectors of triangle
                 let v1 = Vector2D(x: 30, y: -30) // blue
                 let v2 = Vector2D(x: -36, y: -40) // blue
                 let v3 = v1 + v2 // orange
                 
                 // draw vectors
                 let v1Path = v1.asPath(startPoint: centerPoint, hasArrowhead: true)
                 print(v1Path.description)
                 context.stroke(v1Path, with: .color(.blue))
                 let v2Path = v2.asPath(startPath: v1Path)
                 context.stroke(v2Path, with: .color(.blue))
                 let v3Path = v3.asPath(startPoint: centerPoint)
                 context.stroke(v3Path, with: .color(.orange))
                 
                 // similar but different (smaller bottom triangle)
                 let v1_1 = -scale * v1
                 let v2_1 = -scale * v2
                 let v3_1 = -scale * v3

                 // draw vectors
                 let v1_1Path = v1_1.asPath(startPoint: centerPoint)
                 context.stroke(v1_1Path, with: .color(.blue))
                 let v2_1Path = v2_1.asPath(startPath: v1_1Path)
                 context.stroke(v2_1Path, with: .color(.blue))
                 let v3_1Path = v3_1.asPath(startPoint: centerPoint)
                 context.stroke(v3_1Path, with: .color(.orange))

                 // draw center point
                 let centerPointPath = centerPoint.asPath(pointDiameter: 5)
                 context.fill(centerPointPath, with: .color(.red))
             }
             // draw green frame
             Rectangle().stroke(Color(.green))
         }.frame(width: 200, height: 200)
     }
 }
```
 
 ![Example of Vector2D](Vector2D.png)
 */
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

            let newVector = self.copy(magnitude: newMagnitude)

            x = newVector.x
            y = newVector.y
        }
    }
    
    public var perpendicular: Vector2D {
        Vector2D(x: -y, y: x)
    }

    public var normalized: Vector2D {
        let currMagnitude = magnitude
        return Vector2D(x: x/currMagnitude, y: y/currMagnitude)
    }
    
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

// operator

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


// Connection to Core Graphics
extension Vector2D {
    
    
    /// Provides a path that represents the vector.
    /// - Parameters:
    ///   - startPoint: The origin of the vector, where to start drawing the vector.
    ///   - hasArrowhead: Should the arrowhead be drawn.
    /// - Returns: Path
    public func asPath(startPoint: Point2D, hasArrowhead: Bool = true) -> Path {
        Path { path in
            path.move(to: startPoint.asCGPoint)
            path.addLine(to: (startPoint + self).asCGPoint)
            
            if hasArrowhead {
                let posVec = PositionalVector2D(point: startPoint, vector: self)
                let arrowHeadPath = posVec.arrowHeadPath()
                path.addPath(arrowHeadPath)
            }
    }
    }

    
    /// Create a path that starts at the last point fo the startPath path
    /// - Parameter startPath: The previous path to build off on.
    /// - Returns: A new path that used startPath as a starting point
    public func asPath(startPath: Path, hasArrowhead: Bool = true) -> Path {
        Path { path in
            // draw line
            let lastPoint = startPath.currentPoint?.asPoint2D ?? Point2D(x: 0.0, y: 0.0)
            path.addPath(self.asPath(startPoint: lastPoint))
        }
    }

    /// Vector draws itself in SwiftUI's Canvas, but doesn't fullfill Drawable protocol because startPoint must also be provided.
    public func draw(startPoint: Point2D, context: inout GraphicsContext) {
        let vector2DPath = asPath(startPoint: startPoint, hasArrowhead: true)
        context.stroke(vector2DPath, with: .color(.red))
    }
}

extension Vector2D {

    /// Functional way to adjust a value in the vector
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    /// - Returns: A new Vector2D with any adjustments
    public func copy(x: Double?, y: Double?) -> Vector2D {

        var newX = self.x
        var newY = self.y

        if let x = x { newX = x }
        if let y = y { newY = y }

        return Vector2D(x: newX, y: newY)
    }

    /// A functional way to change the magnitude of a function
    ///
    /// - Parameter magnitude: how long the vector should be
    /// - Returns: A new vector with the same ratio between x/y but has a new magnitude
    public func copy(magnitude: Double) -> Vector2D {
        
        let xSign: Double = x >= 0.0 ? 1.0 : -1.0
        let ySign: Double = y >= 0.0 ? 1.0 : -1.0
        let ratioXoverY: Double = abs(x)/abs(y)  // this can substitute a y value (ratio * y)^2 + (y)^2
        let addOtherY: Double = pow(ratioXoverY, 2) + 1  // add lhs ((ratio)^2 * y^2) + y^2 -> ((ratio)^2 + 1) y^2

        let applySqrt: Double = sqrt(addOtherY)

        let newYScale: Double = (1/applySqrt) * magnitude
        let newXScale: Double = ratioXoverY * newYScale

        return Vector2D(x: xSign * newXScale, y: ySign * newYScale)
    }
}

extension CGVector {

    /// Convect CGVector to Vector2D
    public var asVector2D: Vector2D {
        Vector2D(x: dx, y: dy)
    }
}
