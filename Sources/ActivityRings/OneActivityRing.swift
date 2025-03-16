//
//  OneActivityRing.swift
//  ActivityRings
//
//  Created by Daniel Lyons on 2025-03-16.
//

import Foundation
import SwiftUI

/// A single activity ring.
public struct OneActivityRing: View {
    let value: Double
    let style: AnyShapeStyle
    let lineWidth: CGFloat
    
    public init(value: Double, style: some ShapeStyle, lineWidth: CGFloat) {
        self.value = value
        self.style = AnyShapeStyle(style)
        self.lineWidth = lineWidth
    }
    
    public var body: some View {
        ActivityRings(
            rings: [
                .init(value: value, style: style)
            ],
            ringSpacing: 0,
            lineWidth: lineWidth
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
