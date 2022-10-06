import SwiftUI

struct ScrollViewOffsetViewModifer: ViewModifier {
    @State private var startOffset: CGFloat = 0
    @Binding var contentOffset: CGFloat
    @Binding var scrollMaxOffset: CGFloat
    let scrollViewHeight: CGFloat
    let onScroll: () -> Void

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollViewPreferenceKey.self, value: geometry.frame(in: .global))
                }
            )
            .onPreferenceChange(ScrollViewPreferenceKey.self) { frame in
                DispatchQueue.main.async {
                    if startOffset == 0 {
                        startOffset = frame.minY
                    }
                    scrollMaxOffset = frame.size.height - scrollViewHeight
                    contentOffset = startOffset - frame.minY
                    onScroll()
                }
            }
    }
}
