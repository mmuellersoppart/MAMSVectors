//
//  Point2D.swift
//  
//
//  Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation
import CoreGraphics
import SwiftUI

/**
A traditional 2-dimensional point in a cartesian plane (CGPoint)
 
Example of use
```swift
import SwiftUI
import MAMSVectors

struct Point2DExample: View {
    var body: some View {
        ZStack {
            Canvas { context, size in
                // draw grid
                for y in stride(from: 0, to: size.height, by: 20) {
                    for x in stride(from: 0, to: size.width, by: 20) {
                        Point2D(x: Double(x), y: Double(y)).draw(context: &context)
                    }
                }
                // draw blue dot
                let ptPath = Point2D(x: 60, y: 60).asPath(pointDiameter: 10)
                context.fill(ptPath, with: .color(.blue))
            }
            // draw green frame
            Rectangle().stroke(Color(.green))
        }.frame(width: 200, height: 200)
    }
}

struct Point2DExample_Previews: PreviewProvider {
    static var previews: some View {
        Point2DExample()
    }
}
```
 
 ![Example of Points](Point2D.png)
 */
public struct Point2D {
    public var x: Double
    public var y: Double

    
    /// Creates the equivalent CGPoint to interface with Core Graphics
    public var asCGPoint: CGPoint {
        CGPoint(x: x, y: y)
    }

    /// Publicly defines the Point2D memberwise constructor
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point2D: Drawable {
    
    
    /// Gives the distance between two points (L2 norm)
    /// - Parameter point: A point to compare against.
    /// - Returns: The distance.
    public func distance(to point: Point2D) -> Double {
        let xDist = point.x - x
        let yDist = point.y - y
        
        return sqrt((xDist * xDist) + (yDist * yDist))
    }
    
    /// Creates a copy of a point. A user may want to change member variables and those values
    /// can be inputted. The unfilled values will be the same as the original Vector.
    ///
    /// - Parameters:
    ///   - x: a replacement value for x
    ///   - y: a replacement value for y
    /// - Returns: a copy of the original vector with possible modifications
    public func copy(x: Double? = nil, y: Double? = nil) -> Point2D {
        var newX = self.x
        var newY = self.y

        if let x = x { newX = x }
        if let y = y { newY = y }

        return Point2D(x: newX, y: newY)
    }
}

// Connection to Core Graphics
@available(iOS 15.0, *)
@available(macOS 15.0, *)
extension Point2D {

    /// Convert Point2D into a path that can be used within swiftUI's canvas
    ///
    /// A simple use case
    /// ```
    /// canvas { context, size in
    ///     let pt = Point2D(x: 1, y: 1)
    ///     let path = pt.asPath(pointDiameter = 2)
    ///     context.stroke(path, with: Color(.green))
    /// }
    /// ```
    ///
    /// - Parameter pointDiameter: The diameter of the circle that surrounds the point
    /// - Returns: A Path
    public func asPath(pointDiameter: Double = 1) -> Path {
        Path { path in
            path.move(to: asCGPoint)

            // find origin (upperLeftPoint)
            let posVec = PositionalVector2D(origin: self, vector: Vector2D(x: -(pointDiameter / 2.0), y: -(pointDiameter / 2.0)))

            let circleRectangle = CGRect(origin: posVec.tip.asCGPoint, size: CGSize(width: pointDiameter, height: pointDiameter))
            path.addEllipse(in: circleRectangle)
        }
    }

    /// Allows the instances of Point2D to draw itself with a default configuration.
    ///
    /// A simple use case
    /// ```
    /// canvas { context, size in
    ///     let pt = Point2D(x: 1, y: 1)
    ///     pt.draw(context: context)
    /// }
    /// ```
    public func draw(context: inout GraphicsContext) {
       let point2DPath = asPath()
        context.stroke(point2DPath, with: .color(.red))
    }
}

// operators

extension Point2D : Equatable {
    public static func +(lhs: Point2D, rhs: Point2D) -> Point2D {
        Point2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y) 
    }
}

extension Point2D {
    public static func == (lhs: Point2D, rhs: Point2D) -> Bool {
        (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
}

extension CGPoint {
    public var asPoint2D: Point2D {
        Point2D(x: x, y: y)
    }
}

