//
//  HomeView.swift
//  swiftui-stacked-scrollview
//
//  Created by Huisoo on 8/12/26.
//

import SwiftUI

struct HomeView: View {
    @State private var showWallpapers: Bool = false
    @Namespace private var animation
    
    var body: some View {
        VStack {
            Text("ADD NEW")
                .fontWeight(.medium)
            
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(.fill.tertiary)
                    .aspectRatio(0.452, contentMode: .fit)
                
                VStack {
                    Text("9:41")
                        .font(.system(size: 90, weight: .medium, design: .rounded))
                        .padding(.top, 36)
                        .blendMode(.softLight)
                    
                    Spacer(minLength: 0)
                }
                
                Button {
                    showWallpapers.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .fontWeight(.medium)
                        .frame(width: 24, height: 36)
                }
                .buttonStyle(.glass)
                .matchedTransitionSource(id: "VIEW", in: animation)
            }
        }
        .padding(48)
        .fullScreenCover(isPresented: $showWallpapers) {
            WallpaperPackView()
                .navigationTransition(.zoom(sourceID: "VIEW", in: animation))
        }
    }
}

#Preview {
    ContentView()
}
