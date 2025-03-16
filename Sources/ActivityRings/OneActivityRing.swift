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
