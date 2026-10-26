//
//  LaunchScreen.swift
//  swiftui-animated-launch-screen
//
//  Created by Huisoo on 10/26/26.
//

import SwiftUI

struct LaunchConfig {
    var logo: Image = .init(.launchIcon)
    var tint: Color = .black
    var initialDelay: CGFloat = 0.35
    
    var iconPadding: CGFloat = 30
    var iconSize: CGSize = .init(width: 150, height: 150)
    var iconRadius: CGFloat = 45
}

extension View {
    @ViewBuilder
    func splashSreen<Onboarding: View>(
        config: LaunchConfig,
        showOnboarding: Bool,
        @ViewBuilder onboarding: () -> Onboarding
    ) -> some View {
        self
            .modifier(LaunchScreenModifier(
                config: config,
                showOnboarding: showOnboarding,
                onboarding: onboarding
            ))
    }
}

struct LaunchScreenModifier<Onboarding: View>: ViewModifier {
    var config: LaunchConfig
    var showOnboarding: Bool
    @ViewBuilder var onboarding: Onboarding
    
    @State private var addSplash: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: toggleSplash)
            .fullScreenCover(isPresented: $addSplash) {
                ZStack {
                    if showOnboarding {
                        LaunchScreenWithOnboarding(config: config) {
                            onboarding
                        }
                    } else {
                        LaunchScreenOnly(config: config)
                            .presentationBackground(.clear)
                    }
                }
            }
    }
    
    private func toggleSplash() {
        DispatchQueue.main.async {
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                addSplash.toggle()
            }
        }
    }
}

private struct LaunchScreenWithOnboarding<Content: View>: View {
    var config: LaunchConfig
    @ViewBuilder var onboarding: Content
    
    @State private var pushIcon: Bool = false
    @State private var animateIcon: Bool = false
    
    var body: some View {
        let layout = animateIcon ? AnyLayout(VStackLayout(spacing: 0)) : AnyLayout(ZStackLayout(alignment: .bottom))
        
        layout {
            ZStack {
                RoundedRectangle(cornerRadius: animateIcon ? config.iconRadius : 0)
                    .fill(config.tint)
                
                config.logo
                    .frame(
                        width: animateIcon ? config.iconSize.width : nil,
                        height: animateIcon ? config.iconSize.height : nil
                    )
                    .animation(.none) { content in
                        content.opacity(animateIcon ? 0 : 1)
                    }
                    .overlay {
                        config.logo
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .animation(.none) { content in
                                content.opacity(animateIcon ? 1 : 0)
                            }
                            .padding(animateIcon ? config.iconPadding : 0)
                    }
            }
            .frame(
                width: animateIcon ? config.iconSize.width : nil,
                height: animateIcon ? config.iconSize.height : nil
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(y: pushIcon ? 100 : 0)
            .zIndex(1)
            .geometryGroup()
            .ignoresSafeArea()
            
            onboarding
                .compositingGroup()
                .visualEffect { [animateIcon] content, proxy in
                    return content
                        .blur(radius: animateIcon ? 0 : 15)
                        .opacity(animateIcon ? 1 : 0)
                        .offset(y: animateIcon ? 9 : proxy.size.height)
                }
                .zIndex(0)
        }
        .task {
            guard !animateIcon else { return }
            try? await Task.sleep(for: .seconds(config.initialDelay))
            withAnimation(.bouncy(duration: 0.5, extraBounce: 0.05)) {
                animateIcon = true
                pushIcon = true
            }
            
            try? await Task.sleep(for: .seconds(0.15))
            withAnimation(.bouncy(duration: 0.4)) {
                pushIcon = false
            }
        }
    }
}

private struct LaunchScreenOnly: View {
    var config: LaunchConfig
    
    @State private var scaleDown: Bool = false
    @State private var scaleUp: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Rectangle()
            .fill(.clear)
            .overlay {
                GeometryReader {
                    let scaleFactor: CGFloat = 4
                    let size = $0.size
                        .applying(.init(scaleX: scaleFactor, y: scaleFactor))
                    
                    Rectangle()
                        .fill(config.tint)
                        .mask {
                            Rectangle()
                                .overlay {
                                    LogoView(isMask: true, size: size)
                                }
                        }
                        .overlay {
                            LogoView(isMask: false, size: size)
                        }
                }
            }
            .ignoresSafeArea()
            .task {
                guard !scaleDown else { return }
                
                try? await Task.sleep(for: .seconds(config.initialDelay))
                withAnimation(.smooth(duration: 0.3, extraBounce: 0)) {
                    scaleDown = true
                }
                
                try? await Task.sleep(for: .seconds(0.1))
                withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0, initialVelocity: 0)) {
                    scaleUp = true
                }
                
                try? await Task.sleep(for: .seconds(0.6))
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    dismiss()
                }
            }
    }
    
    @ViewBuilder
    private func LogoView(isMask: Bool, size: CGSize) -> some View {
        config.logo
            .blendMode(isMask ? .destinationOut : .normal)
            .scaleEffect(scaleDown ? 0.8 : 1)
            .visualEffect { [scaleUp] content, proxy in
                let imageSize = proxy.size
                let scale = max(size.width / imageSize.width, size.height / imageSize.height)
                
                return content
                    .scaleEffect(scaleUp ? scale : 1)
                    .opacity(isMask ? (scaleUp ? 1 : 0) : (scaleUp ? 0 : 1))
            }
    }
}


#Preview {
    ContentView()
}
