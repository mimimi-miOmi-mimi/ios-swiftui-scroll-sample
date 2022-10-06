import Foundation

enum ScrollDirection {
    // at top
    case top
    // scrolling down, view is moving upward
    case up
    // scrolling up, view is moving downward
    case down
    // at bottom
    case bottom

    var text: String {
        switch self {
        case .top:
            return "start"
        case .up:
            return "up"
        case .down:
            return "down"
        case .bottom:
            return "end"
        }
    }
}
