import SwiftUI


public struct MIBottomDrawer<Content: View>: View {
    
    // Provide the possible resting heights of the drawer
    @Binding public var snapPoints: [CGFloat]
    
    // Hide/Show drawer indicator view at top.
    public var showIndicator: Bool
    
    // Bottom Drawer background color
    public var background: Color
    
    // Bottom Drawer handler background color
    public var handlerBackground: Color
    
    // Bottom Drawer back background color
    public var drawerBackgroundColor: Color
    
    // Provide the current height of the displayed drawer at the initial time
    @State public var height: CGFloat
    
    // The current height marker the drawer is conformed to. Change triggers `onRest`
    @State internal var restingHeight: CGFloat {
        didSet {
            didDrawerRestAt?(restingHeight)
        }
    }
    
    // A callback executed when the drawer reaches a restingHeight
    internal var didDrawerRestAt: ((_ height: CGFloat) -> ())? = nil
    
    // MARK: Orientation
    
    public struct SizeClass: Equatable {
        var horizontal: UserInterfaceSizeClass?
        var vertical: UserInterfaceSizeClass?
    }
    
    @Environment(\.verticalSizeClass) internal var verticalSizeClass
    @Environment(\.horizontalSizeClass) internal var horizontalSizeClass
    @State internal var sizeClass: SizeClass = SizeClass(
        horizontal: nil,
        vertical: nil) {
        didSet { didLayoutForSizeClass?(sizeClass) }
    }
    
    // A callback executed when the drawer is layed out for a new size class
    internal var didLayoutForSizeClass: ((SizeClass) -> ())? = nil
    
    // MARK: Drawer Dragging Gestures
    
    @State internal var dragging: Bool = false
    
    // MARK: Animation COnfiguration
    
    // Additional height to spring past the last height marker
    internal var springHeight: CGFloat = 12
    
    @State internal var animation: Animation? = Animation.spring(dampingFraction: 50.0, blendDuration: 2.0)
    
    // MARK: Haptics
    
    internal var impactGenerator: UIImpactFeedbackGenerator?
    
    // MARK: Content View to show in the Drawer as child view
    
    internal var content: Content
    
}

/*
 * PUBLIC INIT CONSTRUCTORS
 */

// MARK: Public init

public extension MIBottomDrawer {
    
    // A bottom-up view that conforms to multiple heights
    /// - Parameters:
    ///   - heights: The possible resting heights of the drawer
    ///   - startingHeight: The starting height of the drawer. Defaults to the first height marker if not specified
    ///   - content: The view that defines the drawer
    init(
        snapPoints: Binding<[CGFloat]> = .constant([0]),
        startingHeight: CGFloat? = nil,
        showIndicator: Bool? = true,
        background: Color? = .white,
        drawerBackgroundColor: Color? = .clear,
        handlerBackground: Color? = .gray.opacity(0.2),
        @ViewBuilder _ content: () -> Content
    ) {
        var tempValue = snapPoints.wrappedValue.sorted()
        if tempValue.contains(where: { item in
            item < 35
        }) {
            tempValue = tempValue.filter({$0>35})
            tempValue.insert(40.0, at: 0)
        }
        self._snapPoints = .constant(tempValue)
        self._height = .init(initialValue: startingHeight ?? snapPoints.wrappedValue.first!)
        self._restingHeight = .init(initialValue: startingHeight ?? snapPoints.wrappedValue.first!)
        self.showIndicator = showIndicator ?? true
        self.background = background ?? .white
        self.drawerBackgroundColor = drawerBackgroundColor ?? .clear
        self.handlerBackground = handlerBackground ?? .gray.opacity(0.2)
        self.content = content()
    }
}

internal extension MIBottomDrawer {
    init(
        snapPoints: Binding<[CGFloat]>,
        showIndicator: Bool = true,
        background: Color = .white,
        drawerBackgroundColor: Color = .clear,
        handlerBackground: Color = .gray.opacity(0.2),
        height: CGFloat,
        restingHeight: CGFloat,
        springHeight: CGFloat,
        didDrawerRestAt: ((_ height: CGFloat) -> ())?,
        didLayoutForSizeClass: ((SizeClass) -> ())?,
        impactGenerator: UIImpactFeedbackGenerator?,
        content: Content
    ) {
        var tempValue = snapPoints.wrappedValue.sorted()
        if tempValue.contains(where: { item in
            item < 35
        }) {
            tempValue = tempValue.filter({$0>35})
            tempValue.insert(40.0, at: 0)
        }
        self._snapPoints = .constant(tempValue)
        self.background = background
        self.drawerBackgroundColor = drawerBackgroundColor
        self.handlerBackground = handlerBackground
        self.showIndicator = showIndicator
        self._height = .init(initialValue: height)
        self._restingHeight = .init(initialValue: restingHeight)
        self.springHeight = springHeight
        self.didDrawerRestAt = didDrawerRestAt
        self.didLayoutForSizeClass = didLayoutForSizeClass
        self.content = content
        self.impactGenerator = impactGenerator
    }
}
