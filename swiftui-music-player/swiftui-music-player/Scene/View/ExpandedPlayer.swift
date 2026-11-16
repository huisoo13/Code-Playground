//
//  ExpandedPlayer.swift
//  swiftui-music-player
//
//  Created by Huisoo on 11/16/26.
//

import SwiftUI

struct ExpandedPlayer: View {
    /// You can fadeout views all views except artwork a little bit faster or even without animation
    @Binding var config: PlayerContainerConfig

    var size : CGSize
    var safeArea: EdgeInsets
    var namespace: Namespace.ID
    var dismissAction: () -> () = { }
    
    @State private var fadeIn: Bool = false
    
    var body: some View {
        VStack {
            Capsule()
                .fill(.white.secondary)
                .frame(width: 50, height: 4)
                .animation(config.animation.speed(2)) {
                    $0.opacity(config.expandPlayer ? 1 : 0)
                }
                .opacity(fadeIn ? 1 : 0)
            
            Spacer(minLength: 0)
            
            let imageSize: CGFloat = size.width - 120
            RoundedRectangle(cornerRadius: 5)
                .overlay {
                    Color.red
                }
                .clipShape(.rect(cornerRadius: 10))
                .matchedGeometryEffect(id: "Image", in: namespace)
                .frame(width: imageSize, height: imageSize)
                .onTapGesture {
                    dismissAction()
                }
            
            Spacer(minLength: 0)

            controller()
                .animation(config.animation.speed(2)) {
                    $0.opacity(config.expandPlayer ? 1 : 0)
                }
                .opacity(fadeIn ? 1 : 0)

        }
        .padding(.top, safeArea.top)
        .padding(.bottom, safeArea.bottom + 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(
                colors: [.blue.mix(with: .black, by: 0.5), .red.mix(with: .black, by: 0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .onAppear {
            withAnimation(config.animation.delay(0.1)) {
                fadeIn = true
            }
        }
    }
    
    @ViewBuilder
    private func controller() -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Resident Evil 2")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                    
                    Text("Capcom, Co., Ltd.")
                        .fontWeight(.medium)
                        .foregroundStyle(.white.secondary)
                }
                
                Spacer(minLength: 0)

                Button {
                    
                } label: {
                    Image(systemName: "star.circle.fill")
                        .font(.title)
                }
                .foregroundStyle(.white, .white.tertiary)
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.title)
                }
                .foregroundStyle(.white, .white.tertiary)
            }
            
            VStack(spacing: 2) {
                Slider(value: .constant(0.5))
                    .sliderThumbVisibility(.hidden)
                    .tint(.white)
                
                HStack {
                    Text("0:00")
                    Spacer(minLength: 0)
                    Text("4:31")
                }
            }
            .padding(.top, 10)
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "backward.fill")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .contentShape(.rect)
                }

                Button {
                    
                } label: {
                    Image(systemName: "play.fill")
                        .font(.system(size: 50))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .contentShape(.rect)
                }

                Button {
                    
                } label: {
                    Image(systemName: "forward.fill")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .contentShape(.rect)
                }
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .frame(maxHeight: 100)
            
            VStack(spacing: 2) {
                HStack(spacing: 10) {
                    Image(systemName: "speaker.fill")
                        .foregroundStyle(.white.secondary)
                    
                    Slider(value: .constant(1))
                        .sliderThumbVisibility(.hidden)
                        .tint(.white)
                    
                    Image(systemName: "speaker.wave.3.fill")
                        .foregroundStyle(.white.secondary)
                }
                
                HStack(spacing: 10) {
                    Image(systemName: "quote.bubble")
                        .frame(maxWidth: .infinity)

                    Image(systemName: "airpods.gen4")
                        .frame(maxWidth: .infinity)

                    Image(systemName: "list.dash")
                        .frame(maxWidth: .infinity)
                }
                .font(.title3)
                .foregroundStyle(.white)
                .padding(.top, 10)
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 30)
        .compositingGroup()
    }
}

#Preview {
    ContentView()
        .colorScheme(.dark)
}
