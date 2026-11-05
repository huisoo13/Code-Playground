//
//  Extension+View.swift
//  swiftui-spotlight-onboarding
//
//  Created by Huisoo on 11/5/26.
//

import SwiftUI

struct Highlight: Identifiable {
    var id: Int
    var title: String
    var description: String
    var maskShape: AnyShape
    var inset: CGFloat
    var frame: CGRect
}


extension View {
    @ContentBuilder
    func highlight<S: Shape>(order: Int, title: String, description: String, maskShape: S, inset: CGFloat = 10, group: Binding<[Int: Highlight]>) -> some View {
        self.onGeometryChange(for: CGRect.self) {
            $0.frame(in: .global)
        } action: { newValue in
            let highlight = Highlight(id: order, title: title, description: description, maskShape: AnyShape(maskShape), inset: inset, frame: newValue)
            group.wrappedValue[order] = highlight
        }
        .onDisappear {
            /// Removing when view disappears
            group.wrappedValue[order] = nil
        }
    }
    
    @ContentBuilder
    func highlightOverlay(isPresented: Binding<Bool>, group: Binding<[Int: Highlight]>) -> some View {
        self.fullScreenCover(isPresented: isPresented) {
            HighlightView(isPresented: isPresented, group: group)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .presentationBackground(.clear)
                .navigationTransition(.crossFade)   /// iOS27 +  .crossFade 
        }
    }
    
    @ContentBuilder
    fileprivate func inverseMask<Content: View>(alignment: Alignment = .center, @ContentBuilder content: () -> Content) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    content()
                        .blendMode(.destinationOut)
                }
        }
    }
}

fileprivate struct HighlightView: View {
    @Binding var isPresented: Bool
    @Binding var group: [Int: Highlight]
    
    @State private var currentHighlight: Highlight?
    @State private var containerSize: CGSize = .zero
    
    var body: some View {
        Rectangle()
            .fill(.black.opacity(0.7))
            .inverseMask(alignment: .topLeading) {
                if let currentHighlight {
                    let frame = currentHighlight.frame
                    let origin = frame.origin
                    let inset = currentHighlight.inset
                    
                    currentHighlight.maskShape
                        .frame(width: frame.width + inset, height: frame.height + inset)
                        .offset(x: origin.x - inset / 2, y: origin.y - inset / 2)
                }
            }
            .overlay(alignment: .topLeading) {
                let frame = currentHighlight?.frame ?? .zero
                let origin = frame.origin
                let inset = currentHighlight?.inset ?? 0
                 
                let edge: Edge = origin.y > (containerSize.height / 2) ? .bottom : .top
                
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(width: frame.width + inset, height: frame.height + inset)
                    .popover(item: $currentHighlight, arrowEdge: edge) { highlight in
                        popoverView(highlight: highlight)
                            .frame(maxWidth: .infinity)
                            .presentationCompactAdaptation(.popover)
                            .interactiveDismissDisabled()
                    }
                    .offset(x: origin.x - inset / 2, y: origin.y - inset / 2)
            }
            .onGeometryChange(for: CGSize.self) {
                $0.size
            } action: { newValue in
                containerSize = newValue
            }
            .task {
                try? await Task.sleep(for: .seconds(0.25))
                if let highlight = group[0] {
                    withAnimation(animation) {
                        currentHighlight = highlight
                    }
                } else {
                    isPresented = false
                }
            }
    }
    
    @ContentBuilder
    private func popoverView(highlight: Highlight) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("\(highlight.id + 1) of \(group.count)")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(highlight.title)
                    .font(.title3.bold())
                    .lineLimit(1)
                
                Text(highlight.description)
                    .lineLimit(2, reservesSpace: true)
                    .multilineTextAlignment(.leading)
            }
            .padding(.bottom, 4)
            
            HStack {
                Button("Skip") {
                    isPresented = false
                }
                .tint(.secondary)
                
                Spacer(minLength: 0)
                
                let isLast = highlight.id == group.count - 1
                Button {
                    if isLast {
                        isPresented = false
                    } else {
                        withAnimation(animation) {
                            let nextIndex = min(highlight.id + 1, group.count - 1)
                            currentHighlight = group[nextIndex]
                        }
                    }
                } label: {
                    Text(isLast ? "Finish" : "Next")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 4)
                }
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.capsule)
            }
        }
        .padding(20)
    }
    
    private var intiialDelay: Double {
        return 0.25
    }
    
    private var animation: Animation {
        return .interactiveSpring(duration: 0.25, extraBounce: 0, blendDuration: 0)
    }
}

#Preview {
    ContentView()
}
