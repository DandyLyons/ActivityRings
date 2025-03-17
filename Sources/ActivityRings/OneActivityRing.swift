//
//  OneActivityRing.swift
//  ActivityRings
//
//  Created by Daniel Lyons on 2025-03-16.
//

import Foundation
import SwiftUI

/// A single activity ring.
///
/// The frame of the SwiftUI View will determine the ring's diameter. The View will try to take up as much space
/// as it is given. 
public struct OneActivityRing: View {
    /// A `Double` representing a percentage, as a value between 0 (0%) and 1 (100%).
    let value: Double
    /// The appearance of the ring
    let style: AnyShapeStyle
    /// the width of the ring's line.
    let lineWidth: CGFloat
    
    public init(value: Double, style: some ShapeStyle, lineWidth: CGFloat) {
        self.value = value
        self.style = AnyShapeStyle(style)
        self.lineWidth = lineWidth
    }
    
    public var body: some View {
        ActivityRings(
            lineWidth: lineWidth, ringSpacing: 0, rings: [
                .init(value: value, style: style)
            ]
        )
    }
}

#Preview {
    OneActivityRing(
        value: 0.75,
        style: Color.green,
        lineWidth: 20
    )
    .padding()
}
