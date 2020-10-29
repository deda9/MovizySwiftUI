import SwiftUI

public struct LoadingView<Content>: View where Content: View {
    
    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            LazyVStack(alignment: .center) {
                ProgressView {
                    self.content()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.black.opacity(0.3))
        }
        .edgesIgnoringSafeArea(.all)
    }
}
