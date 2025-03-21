import IdentifiedCollections
import SwiftUI

/// A view that displays multiple concentric activity rings, similar to Apple's Activity app.
/// Each ring represents a different metric and can be customized with different colors and values.
public struct ActivityRings: View {
    /// Creates an ``ActivityRings`` View
    /// - Parameters:
    ///   - lineWidth: the width of each ring's line.
    ///   - ringSpacing: the padding between each ring.
    ///   - rings: The percentage value and styling of each ring. Note: Internally, this initializer uses the Array
    ///   index of each element to create a stable id. This means that adding or removing ``ActivityRingConfig``
    ///   elements could produce surprising animation behaviors. For more info see ``ActivityRings/rings``. 
    public init(
        lineWidth: CGFloat = 4,
        ringSpacing: CGFloat = 0,
        rings: [ActivityRingConfig]
    ) {
        self.rings = rings.asIDArray()
        self.ringSpacing = ringSpacing
        self.lineWidth = lineWidth
    }
    
    /// Configuration for each activity ring to be displayed.
    /// Rings are displayed from outside to inside in the order provided.
    var rings: IdentifiedArrayOf<ActivityRingConfig>
    
    /// The spacing between adjacent rings in points.
    /// Positive values create space between rings, while negative values can create overlapping effects.
    public var ringSpacing: CGFloat
    
    /// The thickness of each ring's stroke in points.
    /// Default value is 20 points.
    public var lineWidth: CGFloat = 20
    
    /// The view body that renders the concentric activity rings.
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Create rings from outside to inside
                ForEach(rings) { ring in
                    ActivityRingView(
                        value: ring.value,
                        style: ring.style,
                        diameter: diameter(
                            for: rings.index(id: ring.id) ?? -1,
                            in: geometry.size
                        ),
                        lineWidth: lineWidth
                    )
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .aspectRatio(1, contentMode: .fit) // Maintain square aspect ratio
    }
    
    /// Calculates the appropriate diameter for each ring based on its position.
    /// - Parameters:
    ///   - index: The index of the ring in the rings array (0 is outermost).
    ///   - size: The available size for the entire view.
    /// - Returns: The calculated diameter for the ring at the given index.
    private func diameter(for index: Int, in size: CGSize) -> CGFloat {
        guard index >= 0 else {
            assertionFailure("index should be 0 or higher")
            return 0
        }
        let maxDiameter = min(size.width, size.height)
        let totalReducedDiameter = CGFloat(rings.count - 1) * (lineWidth + ringSpacing)
        let outerDiameter = maxDiameter - totalReducedDiameter
        
        return outerDiameter - CGFloat(index) * ((lineWidth * 2) + ringSpacing)
    }
}

/// A demo view that showcases the ActivityRings component with interactive controls.
/// This view allows adjusting ring values, spacing, and line width in real-time.
@available(iOS 16.0, *)
struct ActivityRingsExample: View {
    /// Spacing between adjacent rings, controlled by a slider.
    @State private var ringSpacing: CGFloat = 0
    
    /// Thickness of each ring's stroke, controlled by a slider.
    @State private var lineWidth: CGFloat = 20
    
    /// Value for the red (outermost) ring, representing percentage completion.
    @State private var ring1Value: Double = 0.85
    
    /// Value for the green (second) ring, representing percentage completion.
    @State private var ring2Value: Double = 0.61
    
    /// Value for the blue (third) ring, representing percentage completion.
    @State private var ring3Value: Double = 0.45
    
    /// Value for the purple (innermost) ring, representing percentage completion.
    @State private var ring4Value: Double = 0.0
    
    /// The view body that renders the interactive demo.
    var body: some View {
        NavigationView {
            List {
                // Display the ActivityRings component
                ActivityRings(
                    lineWidth: lineWidth, ringSpacing: ringSpacing, rings: .autoIncrementing([
                        ActivityRingConfig(value: ring1Value, style: Color.red),
                        ActivityRingConfig(value: ring2Value, style: Color.green),
                        ActivityRingConfig(value: ring3Value, style: Color.blue),
                        ActivityRingConfig(value: ring4Value, style: Color.purple)
                    ])
                )
                .frame(width: 250, height: 250)
                .padding()
                
                Text("Customize Values")
                    .font(.headline)
                    .padding(.top)
                
                // Interactive controls for customizing the rings
                VStack(spacing: 16) {
                    VStack {
                        Text("Ring Spacing: \(ringSpacing) points")
                        Slider(value: $ringSpacing, in: -1...2)
                    }
                    
                    VStack {
                        Text("Line Width: \(lineWidth) points")
                        Slider(value: $lineWidth, in: -1...2)
                    }
                    
                    VStack {
                        Text("Red Ring: \(ring1Value.formatted(percentFormatStyle))")
                        Slider(value: $ring1Value, in: 0...2)
                            .tint(.red)
                    }
                    
                    VStack {
                        Text("Green Ring: \(ring2Value.formatted(percentFormatStyle))")
                        Slider(value: $ring2Value, in: 0...2)
                            .tint(.green)
                    }
                    
                    VStack {
                        Text("Blue Ring: \(ring3Value.formatted(percentFormatStyle))")
                        Slider(value: $ring3Value, in: 0...2)
                            .tint(.blue)
                    }
                    
                    VStack {
                        Text("Purple Ring: \(ring4Value.formatted(percentFormatStyle))")
                        Slider(value: $ring4Value, in: 0...2)
                            .tint(.purple)
                    }
                }
                .padding()
            }
            .navigationTitle("ActivityRings Demo")
        }
    }
    
    var percentFormatStyle: FloatingPointFormatStyle<Double>.Percent {
        return .percent.precision(.fractionLength(0...2))
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        ActivityRingsExample()
    } else {
        // Fallback on earlier versions
        Text("Preview in iOS 16 or higher")
    }
}
