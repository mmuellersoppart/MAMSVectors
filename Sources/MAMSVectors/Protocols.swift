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
public protocol Drawable {
    func draw(context: inout GraphicsContext)
}
