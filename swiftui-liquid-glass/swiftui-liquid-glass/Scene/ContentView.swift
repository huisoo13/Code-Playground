//
//  ContentView.swift
//  swiftui-liquid-glass
//
//  Created by Huisoo on 7/21/25.
//
/*
 https://developer.apple.com/documentation/swiftui/landmarks-building-an-app-with-liquid-glass
 https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass
 https://www.donnywals.com/exploring-tab-bars-on-ios-26-with-liquid-glass/
 https://medium.com/@himalimarasinghe/build-a-stunning-uikit-app-with-liquid-glass-in-ios-26-2a0d4427ff8e
 https://developer.apple.com/videos/play/wwdc2025/323
 https://medium.com/@battello.theo/how-to-disable-liquid-glass-when-building-for-ios-26-ed81d03f7633
 */

import SwiftUI

struct ContentView: View {
    @State var text: String = ""

    var body: some View {
        TabView {
            Tab("xmark", systemImage: "xmark") {
                NavigationStack {
                    
                    ListView()
                        .toolbar {
                            ToolbarItem {
                                Label("1", systemImage: "square.dashed")
                            }
                            
                            ToolbarSpacer(.flexible)
                            
                            ToolbarItemGroup {
                                Label("2", systemImage: "square.dashed")
                                Label("3", systemImage: "square.dashed")
                            }
                            
                            ToolbarSpacer(.flexible)
                            ToolbarItem {
                                HStack(spacing: 8) {
                                    Label("4", systemImage: "square.dashed")
                                        .padding(4)
                                    Label("5", systemImage: "square.dashed")
                                        .padding(4)
                                }
                            }
                        }
                }
            }
            
            Tab("circle", systemImage: "circle") {
                ImageBackgroundView()
            }
            
            Tab(role: .search) {
                NavigationStack {
                    ListView()
                }
            }
        }
        .tint(Color.black)
        .tabBarMinimizeBehavior(.onScrollDown)
        .tabViewBottomAccessory {
            Button {
                print("Accessory")
            } label: {
                Text("Accessory")
            }
        }
        .searchable(text: $text)
    }
}

#Preview {
    ContentView()
}
