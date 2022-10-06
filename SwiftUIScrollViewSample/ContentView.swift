import SwiftUI

struct ContentView: View {
    @State private var scrollDirection: ScrollDirection = .top
    @State private var scrollViewHeight: CGFloat = 0
    @State private var scrollOffset: CGFloat = 0
    @State private var scrollMaxOffset: CGFloat = 0
    @State private var previousOffset: CGFloat = 0
    @State private var diff: CGFloat = 0

    init() {
        UIScrollView.appearance().bounces = false
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.mint)
                        .frame(height: 1000)
                    Text(scrollDirection.text)
                        .foregroundColor(.white)
                }
                .modifier(
                    ScrollViewOffsetViewModifer(
                        contentOffset: $scrollOffset,
                        scrollMaxOffset: $scrollMaxOffset,
                        scrollViewHeight: scrollViewHeight,
                        onScroll: {
                            let currentDiff = scrollOffset - previousOffset
                            if currentDiff + diff > 0 {
                                scrollDirection = .up
                            } else {
                                scrollDirection = .down
                            }
                            if scrollOffset == scrollMaxOffset {
                                scrollDirection = .bottom
                            } else if scrollOffset == 0 {
                                scrollDirection = .top
                            }
                            diff = currentDiff
                            previousOffset = scrollOffset
                        }
                    )
                )
            }
            .overlay(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            scrollViewHeight = geometry.size.height
                        }
                }
            )
            Spacer().frame(height: 20)
            Text("offset: \(scrollOffset)")
            Text("maxOffset: \(scrollMaxOffset)")
        }
        .padding(.horizontal, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
