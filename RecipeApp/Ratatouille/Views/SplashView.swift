import SwiftUI

struct SplashView: View {
    @Binding var splash: Bool
    
    @State private var hat = 0.1
    @State private var degree = 40.0
    @State private var offset = -400
    @State private var opacity = 0.1
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.green, .black]), center: .center, startRadius: 1, endRadius: 260)
            
            Image("RemySplash")
                .onAppear {
                    withAnimation(.easeIn(duration: 3.0)) {
                        self.hat = 0.1
                        self.degree = 40
                        self.offset = -170
                        self.opacity = 1
                    }
                }
            
            Image("RemysHat")
                .scaleEffect(hat)
                .rotationEffect(.degrees(degree))
                .offset(y: CGFloat(offset))
                .opacity(opacity)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.spring(duration: 5.2)) {
                    self.splash = false
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview
{
  SplashView(splash: .constant(true))
}

