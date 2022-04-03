//
//  File.swift
//  
//
//  Created by Marlon Mueller Soppart on 4/2/22.
//

import Foundation

public struct Point2D {
    let x: Double
    let y: Double
}


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
