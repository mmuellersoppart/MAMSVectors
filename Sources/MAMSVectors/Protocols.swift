//
//  Protocals.swift
//  
//
//  Created by Marlon Mueller Soppart on 4/21/22.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
@available(macOS 15.0, *)
/// The protocol signifies that the object that knows how to draw itself on a Canvas. In this package, ``Point2D`` and ``PositionalVector2D`` apply.
public protocol Drawable {
    func draw(context: inout GraphicsContext)
}
