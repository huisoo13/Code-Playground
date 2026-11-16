//
//  ContentView.swift
//  swiftui-music-player
//
//  Created by Huisoo on 11/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var config: PlayerContainerConfig = .init()
    
    var body: some View {
        TabView {
            Tab {
                /// Dommy Scrollview to illustrate minimize tab behaviour
                ScrollView {
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(height: 2000)
                }
            } label: {
                AppTab.home.label
            }
            
            Tab {
                
            } label: {
                AppTab.new.label
            }
            
            Tab {
                
            } label: {
                AppTab.radio.label
            }
            
            Tab {
                
            } label: {
                AppTab.library.label
            }
            
            Tab(role: .search) {
                
            } label: {
                AppTab.search.label
            }
        }
        /// I'm going to place the expanded player as the same tab view context and not as any fullscreencover or any sheet, as it depends on the bottom accessory
        .overlay(alignment: .topLeading) {
            if config.attachExpandedPlayer {
                PlayerContainer(config: $config)
                    .transition(.identity)
            }
        }
        .tabViewBottomAccessory(isEnabled: !config.attachExpandedPlayer) {
            PlayerContainer(config: $config)
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        .tint(.pink)
    }
}

#Preview {
    ContentView()
        .colorScheme(.dark)
}
