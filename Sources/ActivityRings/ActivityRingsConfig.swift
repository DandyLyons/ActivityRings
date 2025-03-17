//
//  ActivityRingsConfig.swift
//  ActivityRings
//
//  Created by Daniel Lyons on 2025-03-15.
//

import Foundation
import SwiftUI

/// A configuration for a ring inside of an ``ActivityRings`` View.
public struct ActivityRingConfig {
    /// Percentage value (0-100+)
    public var value: Double
    /// Custom style for this ring
    public var style: AnyShapeStyle
    
    
    public init(value: Double, style: some ShapeStyle) {
        self.value = value
        self.style = AnyShapeStyle(style)
    }
}

struct ActivityRingsConfigWithID: Identifiable {
    let id: Int
    var config: ActivityRingConfig
    
    var value: Double {
        get { config.value }
        set { config.value = newValue }
    }
    var style: AnyShapeStyle {
        get { config.style }
        set { config.style = newValue }
    }
}
