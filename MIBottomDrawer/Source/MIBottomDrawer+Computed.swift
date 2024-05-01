import SwiftUI

extension MIBottomDrawer {
    // MARK: Height Calculation
    
    // The height of the drawer to be shown at maximum spring height
    internal var fullHeight: CGFloat {
        return snapPoints.max()! + springHeight
    }
    
    internal var activeBound: ClosedRange<CGFloat> {
        return snapPoints.min()!...snapPoints.max()!
    }
    
    // MARK: View
    
    private var offset: CGFloat {
        if !dragging && !snapPoints.contains(restingHeight) {
            DispatchQueue.main.async {
                let newRestingHeight = MIBottomDrawer.drawerCloseEndDrag(self.restingHeight, markers: self.snapPoints)
                self.restingHeight = newRestingHeight
                self.height = newRestingHeight
            }
        }
        return -$height.wrappedValue
    }
    
    public var body: some View {
        
        if (sizeClass != SizeClass(
                horizontal: horizontalSizeClass,
                vertical: verticalSizeClass)) {
            DispatchQueue.main.async {
                self.sizeClass = SizeClass(
                    horizontal: self.horizontalSizeClass,
                    vertical: self.verticalSizeClass)
            }
        }
        
        return ZStack(alignment: Alignment(horizontal: .center,
                                           vertical: .bottom)) {
            
            GeometryReader { proxy in
                
                ZStack {
                    RoundedRectangle(cornerRadius: 32)
                        .foregroundColor(background)
                    
                    VStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 3.0)
                                .foregroundColor(.gray.opacity(0.88))
                                .frame(width: 40.0, height: self.showIndicator ? 6.0 : 0.0)
                        }
                        .padding(.vertical, 20.0)
                        .frame(width: proxy.frame(in: .global).width)
                        .background(handlerBackground)
                        .clipShape(.rect(topLeadingRadius: 32, topTrailingRadius: 32))
                        .shadow(radius: 5.0, y: -0.5)
                        self.content
                            .padding(5)
                        Spacer()
                    }
                    .padding(.horizontal, 5)
                    .frame(width: proxy.frame(in: .global).width)
                    .background(.clear)
                }
                .offset(y: proxy.frame(in: .global).height + self.offset)
                .frame(maxHeight: .infinity)
                .animation(self.animation, value: restingHeight)
                .gesture(self.dragGesture)
                .edgesIgnoringSafeArea(.all)
            }
        }
                                           .background(drawerBackgroundColor.opacity((self.height != 40.0 || height != snapPoints.first ?? 0.40) ? 0.3 : 0))
    }
}
