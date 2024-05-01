import SwiftUI

public extension MIBottomDrawer {
    
    // Sets the resting heights of the drawer
    // - Parameter heights: Possible resting heights for the drawer
    // - Returns: MIDrawer
    func snapPoint(at snapPoints: Binding<[CGFloat]>) -> MIBottomDrawer {
        return MIBottomDrawer(
            snapPoints: snapPoints,
            showIndicator: showIndicator,
            background: background,
            drawerBackgroundColor: drawerBackgroundColor,
            handlerBackground: handlerBackground,
            height: height,
            restingHeight: restingHeight,
            springHeight: springHeight,
            didDrawerRestAt: didDrawerRestAt,
            didLayoutForSizeClass: didLayoutForSizeClass,
            impactGenerator: impactGenerator,
            content: content)
    }
    
    // Sets the springiness of the drawer when pulled past boundaries
    // - Parameter spring: A positive number, in pixels, to define how far the drawer can be streched beyond bounds
    // - Returns: MIDrawer with specified spring level
    func spring(_ spring: CGFloat) -> MIBottomDrawer {
        return MIBottomDrawer(
            snapPoints: $snapPoints,
            showIndicator: showIndicator,
            background: background,
            drawerBackgroundColor: drawerBackgroundColor,
            handlerBackground: handlerBackground,
            height: self.height,
            restingHeight: restingHeight,
            springHeight: max(spring, 0),
            didDrawerRestAt: didDrawerRestAt,
            didLayoutForSizeClass: didLayoutForSizeClass,
            impactGenerator: impactGenerator,
            content: content)
    }
    
    // Sets the haptic impact of the drawer when resting
    // - Parameter impact: `FeedbackStyle` for impact level
    // - Returns: MIDrawer with specified impact level
    func impact(_ impact: UIImpactFeedbackGenerator.FeedbackStyle) -> MIBottomDrawer {
        let impactGenerator = UIImpactFeedbackGenerator(style: impact)
        return MIBottomDrawer(
            snapPoints: $snapPoints,
            showIndicator: showIndicator,
            background: background,
            drawerBackgroundColor: drawerBackgroundColor,
            handlerBackground: handlerBackground,
            height: height,
            restingHeight: restingHeight,
            springHeight: springHeight,
            didDrawerRestAt: didDrawerRestAt,
            didLayoutForSizeClass: didLayoutForSizeClass,
            impactGenerator: impactGenerator,
            content: content)
    }
    
    // A callback to receive updates when the drawer reaches a new resting level
    // - Parameter didRest: The callback to handle updates
    // - Returns: MIDrawer
    func onRest(_ didRest: @escaping (_ height: CGFloat) -> ()) -> MIBottomDrawer {
        return MIBottomDrawer(
            snapPoints: $snapPoints,
            showIndicator: showIndicator,
            background: background,
            drawerBackgroundColor: drawerBackgroundColor,
            handlerBackground: handlerBackground,
            height: height,
            restingHeight: restingHeight,
            springHeight: springHeight,
            didDrawerRestAt: didRest,
            didLayoutForSizeClass: didLayoutForSizeClass,
            impactGenerator: impactGenerator,
            content: content)
    }
    
    
    // A callback to receive updates when the drawer is layed out for a new size class
    // - Parameter for changing background color
    // - Returns MIDrawer
    func background(_ background: Color) -> MIBottomDrawer {
        return MIBottomDrawer(
            snapPoints: $snapPoints,
            showIndicator: showIndicator,
            background: background,
            drawerBackgroundColor: drawerBackgroundColor,
            handlerBackground: handlerBackground,
            height: height,
            restingHeight: restingHeight,
            springHeight: springHeight,
            didDrawerRestAt: didDrawerRestAt,
            didLayoutForSizeClass: didLayoutForSizeClass,
            impactGenerator: impactGenerator,
            content: content)
    }
    
    // A callback to receive updates when the drawer is layed out for a new size class
    // - Parameter for changing handler Background color
    // - Returns MIDrawer
    func handlerBackground(_ handlerBackground: Color) -> MIBottomDrawer {
        return MIBottomDrawer(
            snapPoints: $snapPoints,
            showIndicator: showIndicator,
            background: background,
            drawerBackgroundColor: drawerBackgroundColor,
            handlerBackground: handlerBackground,
            height: height,
            restingHeight: restingHeight,
            springHeight: springHeight,
            didDrawerRestAt: didDrawerRestAt,
            didLayoutForSizeClass: didLayoutForSizeClass,
            impactGenerator: impactGenerator,
            content: content)
    }
    
    // - Parameter for changing transparent backgroundColor color
    // - Returns MIDrawer
    func transparentBackgroundColor(_ backgroundColor: Color) -> MIBottomDrawer {
        return MIBottomDrawer(
            snapPoints: $snapPoints,
            showIndicator: showIndicator,
            background: background,
            drawerBackgroundColor: backgroundColor,
            handlerBackground: handlerBackground,
            height: height,
            restingHeight: restingHeight,
            springHeight: springHeight,
            didDrawerRestAt: didDrawerRestAt,
            didLayoutForSizeClass: didLayoutForSizeClass,
            impactGenerator: impactGenerator,
            content: content)
    }
    
    
    // A callback to receive updates when the drawer is layed out for a new size class
    // - Parameter didLayoutForSizeClass: The callback to handle size-class updates
    // - Returns: MIDrawer
    func onLayoutForSizeClass(_ didLayoutForSizeClass: @escaping (SizeClass) -> ()) -> MIBottomDrawer {
        return MIBottomDrawer(
            snapPoints: $snapPoints,
            showIndicator: showIndicator,
            background: background,
            drawerBackgroundColor: drawerBackgroundColor,
            handlerBackground: handlerBackground,
            height: height,
            restingHeight: restingHeight,
            springHeight: springHeight,
            didDrawerRestAt: didDrawerRestAt,
            didLayoutForSizeClass: didLayoutForSizeClass,
            impactGenerator: impactGenerator,
            content: content)
    }
}

