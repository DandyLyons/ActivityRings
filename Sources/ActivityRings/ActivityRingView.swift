//
//  ActivityRingView.swift
//  ActivityRings
//
//  Created by Daniel Lyons on 2025-03-15.
//

import Foundation
import SwiftUI

/// A customizable circular ring view that displays progress similar to Apple's Activity Rings.
struct ActivityRingView: View {
    /// The progress value to display, represented as a percentage (0-200).
    /// Values above 100% will cause the ring to overlap itself.
    var value: Double
    
    /// The style/color to apply to the ring.
    /// Use `.opacity(0.2)` for the background track.
    var style: AnyShapeStyle
    
    /// The outer diameter of the ring in points.
    var diameter: CGFloat
    
    /// The thickness of the ring stroke in points.
    var lineWidth: CGFloat
    
    /// Calculated trim value that converts the percentage input to a value between 0 and 2.
    /// - Returns: A CGFloat clamped between 0 and 2, representing up to 200% completion.
    private var trimValue: CGFloat {
        return min(max(CGFloat(value), 0.0), 2.0) // Limit to 200% maximum
    }
    
    /// The rendered view body that constructs the activity ring.
    var body: some View {
        ZStack {
            // Background track
            Circle()
                .stroke(style.opacity(0.2), lineWidth: lineWidth)
                .frame(width: diameter, height: diameter)
            
            // Progress arc
            if value > 0 {
                Circle()
                    .trim(from: 0, to: trimValue)
                    .stroke(
                        style,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90)) // Start from the top (12 o'clock position)
                    .frame(width: diameter, height: diameter)
            } else {
                // For values <= 0, just show line caps (dot)
                Circle()
                    .trim(from: 0, to: 0.001)
                    .stroke(
                        style,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: diameter, height: diameter)
            }
        }
    }
}
