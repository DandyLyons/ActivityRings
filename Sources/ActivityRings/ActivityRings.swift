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
        var id_rings = IdentifiedArrayOf<ActivityRingsConfigWithID>()
        for (index, ring) in rings.enumerated() {
            id_rings.append(ActivityRingsConfigWithID(id: index, config: ring))
        }
        self.rings = id_rings
        self.ringSpacing = ringSpacing
        self.lineWidth = lineWidth
    }
    
    /// Configuration for each activity ring to be displayed.
    /// Rings are displayed from outside to inside in the order provided.
    ///
    /// Note:
    /// Internally, ``ActivityRings``, uses the Array indices to generate stable ids for animations.
    /// This means that you can safely mutate the ``ActivityRingConfig``'s `value` and `style` and the
    /// correct ring will update. However, this also means that if you add or remove rings, then this may generate
    /// surprising behavior. For example, if the first ring is removed, then the second ring would become the first ring, and would now have the same id that the first ring used to have.
    var rings: IdentifiedArrayOf<ActivityRingsConfigWithID>
    
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
                        diameter: diameter(for: ring.id, in: geometry.size),
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
        let maxDiameter = min(size.width, size.height)
        let totalReducedDiameter = CGFloat(rings.count - 1) * (lineWidth + ringSpacing)
        let outerDiameter = maxDiameter - totalReducedDiameter
        
        return outerDiameter - CGFloat(index) * ((lineWidth * 2) + ringSpacing)
    }
}

/// A demo view that showcases the ActivityRings component with interactive controls.
/// This view allows adjusting ring values, spacing, and line width in real-time.
struct ActivityRingsExample: View {
    /// Spacing between adjacent rings, controlled by a slider.
    @State private var ringSpacing: CGFloat = 0
    
    /// Thickness of each ring's stroke, controlled by a slider.
    @State private var lineWidth: CGFloat = 20
    
    /// Value for the red (outermost) ring, representing percentage completion.
    @State private var ring1Value: Double = 85
    
    /// Value for the green (second) ring, representing percentage completion.
    @State private var ring2Value: Double = 110
    
    /// Value for the blue (third) ring, representing percentage completion.
    @State private var ring3Value: Double = 45
    
    /// Value for the purple (innermost) ring, representing percentage completion.
    @State private var ring4Value: Double = -5
    
    /// The view body that renders the interactive demo.
    var body: some View {
        NavigationView {
            List {
                // Display the ActivityRings component
                ActivityRings(
                    lineWidth: lineWidth, ringSpacing: ringSpacing, rings: [
                        ActivityRingConfig(value: ring1Value, style: Color.red),
                        ActivityRingConfig(value: ring2Value, style: Color.green),
                        ActivityRingConfig(value: ring3Value, style: Color.blue),
                        ActivityRingConfig(value: ring4Value, style: Color.purple)
                    ]
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
                        Slider(value: $ringSpacing, in: -10...150)
                    }
                    
                    VStack {
                        Text("Line Width: \(lineWidth) points")
                        Slider(value: $lineWidth, in: -10...150)
                    }
                    
                    VStack {
                        Text("Red Ring: \(Int(ring1Value))%")
                        Slider(value: $ring1Value, in: -10...150)
                            .tint(.red)
                    }
                    
                    VStack {
                        Text("Green Ring: \(Int(ring2Value))%")
                        Slider(value: $ring2Value, in: -10...150)
                            .tint(.green)
                    }
                    
                    VStack {
                        Text("Blue Ring: \(Int(ring3Value))%")
                        Slider(value: $ring3Value, in: -10...150)
                            .tint(.blue)
                    }
                    
                    VStack {
                        Text("Purple Ring: \(Int(ring4Value))%")
                        Slider(value: $ring4Value, in: -10...150)
                            .tint(.purple)
                    }
                }
                .padding()
            }
            .navigationTitle("ActivityRings Demo")
        }
    }
}

#Preview {
    ActivityRingsExample()
}
