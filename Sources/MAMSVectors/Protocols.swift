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
/// Any object that knows how to draw itself. In this case, ``Point2D`` and ``PositionalVector2D`` apply.
public protocol Drawable {
    func draw(context: inout GraphicsContext)
}
