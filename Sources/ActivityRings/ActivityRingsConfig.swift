//
//  ActivityRingsConfig.swift
//  ActivityRings
//
//  Created by Daniel Lyons on 2025-03-15.
//

import Foundation
import IdentifiedCollections
import SwiftUI

/// A configuration for a ring inside of an ``ActivityRings`` View.
public struct ActivityRingConfig: Identifiable {
    public let id: UUID
    /// Percentage value (0-100+)
    public var value: Double
    /// Custom style for this ring
    public var style: AnyShapeStyle
    
    
    /// Creates a configuration
    ///
    /// Consider explicitly setting the ids to ensure that you do not lose stable ids and thus create unstable
    /// animations. This can be done by explicitly passing a `UUID` to this initializer, using the
    /// `init(intID: Int, value: Double, style: some ShapeStyle)` initializer, or by using the
    /// convennience static methods ``Array<ActivityRingConfig>.autoIncrementing(_:)``.
    /// - Parameters:
    ///   - id: the `UUID` you would like to assign. Pass `nil` if you'd like it to be auto-generated.
    ///   Note: Auto-generated `id` could result in failing animations, due to mismatched ids.
    ///   - value: the value to show, a percent represented by a `Double` between 0 and 1
    ///   - style: the style of the ring
    public init(id: UUID? = nil, value: Double, style: some ShapeStyle) {
        self.id = id ?? UUID()
        self.value = value
        self.style = AnyShapeStyle(style)
    }
    
    /// Creates a configuration, using an `Int` as an id.
    /// - Parameters:
    ///   - intID: the `Int` to use to generate an id.
    ///   - value: the value to show, a percent represented by a `Double` between 0 and 1
    ///   - style: the style of the ring
    public init(intID: Int, value: Double, style: some ShapeStyle) {
        self.id = UUID(intID)
        self.value = value
        self.style = AnyShapeStyle(style)
    }
}

extension [ActivityRingConfig] {
    public static func autoIncrementing(_ array: Self) -> Self {
        var result = Self()
        for (index, element) in array.enumerated() {
            let copy = ActivityRingConfig(intID: index, value: element.value, style: element.style)
            result.append(copy)
        }
        return result
    }
    
    public func asIDArray() -> IdentifiedArrayOf<ActivityRingConfig> {
        IdentifiedArray(uniqueElements: self)
    }
}
