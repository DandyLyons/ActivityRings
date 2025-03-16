//
//  ActivityRingsConfig.swift
//  ActivityRings
//
//  Created by Daniel Lyons on 2025-03-15.
//

import Foundation
import SwiftUI

/// A configuration for a ring inside of an ``ActivityRings`` View.
public struct ActivityRingConfig: Identifiable {
    public let id = UUID()
    /// Percentage value (0-100+)
    public var value: Double
    /// Custom style for this ring
    public var style: AnyShapeStyle
    
    
    init(value: Double, style: some ShapeStyle) {
        self.value = value
        self.style = AnyShapeStyle(style)
    }
}
