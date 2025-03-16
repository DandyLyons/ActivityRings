# ActivityRings

A SwiftUI View that mimics the look and feel of Apple's Activity Rings from the Activity watchOS app. (This SwiftUI view can be used to display any kind of percentage data.)

![Example Image](https://github.com/DandyLyons/ActivityRings/blob/main/Example.png?raw=true)

## Usage
> [!WARNING]
> The library is not currently API stable. Breaking changes may come in future releases.

```swift
ActivityRings(
    rings: [ // the ShapeStyle and value of each ring.
        ActivityRingConfig(value: ring1Value, style: Color.red),
        ActivityRingConfig(value: ring2Value, style: Color.green),
        ActivityRingConfig(value: ring3Value, style: Color.blue),
        ActivityRingConfig(value: ring4Value, style: Color.purple)
           ],
    ringSpacing: 4, // the padding between each ring
    lineWidth: 12 // the line width of each ring
)
```
 
 You can also add a single ring.
 
 ```swift
 OneActivityRing(
    value: 0.75,
    style: Color.green,
    lineWidth: 20
 )
 ```

                 
### Features
- You can add as many or few rings as you like.
- Each ring has a customizable `ShapeStyle` (color).
- You can adjust the line width and ring spacing.

## Installation
This is released as a Swift Package and can be installed in the usual fashion. There is only one target, which is also named `ActivityRings`. 
