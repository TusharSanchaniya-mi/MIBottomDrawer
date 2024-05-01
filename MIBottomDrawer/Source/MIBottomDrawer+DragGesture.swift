import SwiftUI

internal extension MIBottomDrawer {
    
    // MARK: Drag Gesture
    
    var dragGesture: some Gesture {
        return DragGesture().onChanged({ (value) in
            self.dragChanged(value)
        }).onEnded({ (value) in
            self.dragEnded(value)
        })
    }
    
    func dragChanged(_ value: DragGesture.Value) {
        dragging = true
        
        height = MIBottomDrawer.drawerOpenDragChange(
            value.startLocation.y
            + restingHeight - value.location.y,
            range: activeBound,
            spring: springHeight)

        animation = .spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.8)
    }
    
    func dragEnded(_ value: DragGesture.Value) {
        dragging = false
        
        let change = value.startLocation.y
            - value.predictedEndLocation.y + restingHeight
        height = MIBottomDrawer.drawerCloseEndDrag(change, markers: snapPoints)
        restingHeight = height
        animation = .spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.impactGenerator?.impactOccurred()
        }
    }
    
    // MARK: Height Calculations
    
    static func drawerCloseEndDrag(_ mark: CGFloat, markers: [CGFloat]) -> CGFloat {
        let first = markers.first!
        return markers.reduce(
            (first, abs(first - mark))
        ) { (current, value) -> (CGFloat, CGFloat) in
            if current.1 > abs(value - mark) {
                return (value, abs(value - mark))
            }
            return current
        }.0
    }
    
    static func drawerOpenDragChange(_ value: CGFloat, range: ClosedRange<CGFloat>, spring: CGFloat) -> CGFloat {
        if range.contains(value) {
            return value
        } else if value > range.upperBound {
            let change = value - range.upperBound
            let x = pow(M_E, Double(change) / Double(spring))
            return -(2 * spring) / CGFloat(1 + x) + spring + range.upperBound
        } else {
            let change = value - range.lowerBound
            let x = pow(M_E, Double(change) / Double(spring))
            return -(2 * spring) / CGFloat(1 + x) + spring + range.lowerBound
        }
    }
}
