//
//  WallpaperStackView.swift
//  swiftui-stacked-scrollview
//
//  Created by Huisoo on 8/12/26.
//

import SwiftUI

///  Custom View which will convert to stak/scrollView with animation
struct WallpaperStackView<Content: View, ButtonView: View>: View {
    var title: String
    var description: String
    
    var trigger: Bool
    var minimiseWallpaperSize: CGSize = .init(width: 81, height: 176)
    var expandedWallpaperSize: CGSize = .init(width: 111, height: 241)
    
    @ViewBuilder var content: Content
    /// Customize this button how you need
    @ViewBuilder var buttonView: ButtonView
    
    @State private var scaleUp: Bool = false
    @State private var expand: Bool = false
    @State private var remove: Bool = false
    @State private var animationTask: DispatchWorkItem?
    @State private var isExpanded: Bool = false
    
    @State private var contentExpandedHeight: CGFloat = 0
    
    var body: some View {
        let layout = scaleUp ? AnyLayout(VStackLayout(alignment: .leading, spacing: 16)) : AnyLayout(ZStackLayout(alignment: .leading))
        
        layout {
            if !remove {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(title)
                            .font(.title.bold())
                            .lineLimit(1)
                        Spacer(minLength: 0)
                    }
                    .padding(.trailing, scaleUp ? 50 : 0)
                    .overlay(alignment: .trailing) {
                        if scaleUp {
                            buttonView
                        }
                    }
                    
                    Group {
                        if scaleUp {
                            Text(description)
                                .lineLimit(2)
                                .transition(.blurReplace)
                        } else {
                            Text(description)
                                .lineLimit(3)
                                .transition(.blurReplace)
                        }
                    }
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    
                    
                    if !scaleUp {
                        buttonView
                            .transition(.identity)
                    }
                }
                .padding(.leading, scaleUp ? 0 : minimiseWallpaperSize.width + 32)
                .transition(.blurReplace.combined(with: .move(edge: scaleUp ? .trailing : .leading)))
            }
            
            if !remove {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 18) {
                        Group(subviews: content) { collection in
                            ForEach(collection.prefix(scaleUp ? collection.count : 3)) { subview in
                                let index = collection.firstIndex(where: { $0.id == subview.id }) ?? 0
                                
                                subview
                                    .frame(width: width, height: height)
                                    .visualEffect { [scaleUp, expand] content, proxy in
                                        let scale = scaleUp ? 1 : 1 - (CGFloat(index) * 0.1)
                                        let minX = proxy.frame(in: .scrollView).minX
                                        
                                        return content
                                            .scaleEffect(scale, anchor: .trailing)
                                            .offset(x: scaleUp ? 0 : CGFloat(index) * 10)
                                            .offset(x: expand ? 0 : -minX)
                                    }
                                    .opacity(index > 2 ? (expand ? 1 : 0) : 1)
                                    .zIndex(Double(-index))
                            }
                        }
                    }
                }
                .allowsHitTesting(expand)
                .frame(height: height)
                .transition(.blurReplace.combined(with: .move(edge: scaleUp ? .trailing : .leading)))

            }
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onGeometryChange(for: CGFloat.self) { proxy in
            proxy.size.height
        } action: { oldValue, newValue in
            if !remove {
                contentExpandedHeight = newValue
            }
        }
        .frame(minHeight: remove ? contentExpandedHeight : minimiseWallpaperSize.height)
        .onChange(of: trigger) { oldValue, newValue in
            isExpanded.toggle()
            
            /// Cancelling previous animation events
            animationTask?.cancel()
            animationTask = nil
            
            
            if isExpanded {
                /// expand
                withAnimation(.interpolatingSpring(duration: 0.35, bounce: 0, initialVelocity: 0)) {
                    remove = false
                    scaleUp = true
                }
                
                animationTask = .init {
                    /// NON-SPRING animation for scroll animation
                    withAnimation(.easeInOut(duration: 0.22)) {
                        expand = true
                    }
                }
                
                guard let animationTask else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.32, execute: animationTask)
            } else {
                /// close
                /// Removing and re-inserting view's just like lock-screen
                withAnimation(.easeInOut(duration: 0.25)) {
                    remove = true
                }
                
                animationTask = .init {
                    scaleUp = false
                    expand = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            remove = false
                        }
                    }
                }
                
                guard let animationTask else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: animationTask)
            }
        }
    }
    
    private var width: CGFloat {
        scaleUp ? expandedWallpaperSize.width : minimiseWallpaperSize.width
    }
    
    private var height: CGFloat {
        scaleUp ? expandedWallpaperSize.height : minimiseWallpaperSize.height
    }
}

#Preview {
    WallpaperPackView()
        .preferredColorScheme(.dark)
}
