//
//  WallpaperPack.swift
//  swiftui-stacked-scrollview
//
//  Created by Huisoo on 8/12/26.
//

import SwiftUI

struct WallpaperPack: Identifiable {
    var id: String
    var description: String
    var imageAssets: [String]
    
    var title: String {
        id
    }
}


let packs: [WallpaperPack] = [
    .init(
        id: "Weather",
        description: "Live weather conditions for your current location.",
        imageAssets: ["W-1", "W-2", "W-3"]
    ),
    .init(
        id: "Astronomy",
        description: "View the current astronomical positioning of the Earth or the Solar System.",
        imageAssets: ["A-1", "A-2", "A-3", "A-4"]
    ),
    .init(
        id: "Kaleidoscope",
        description: "Inspired by a kaleidoscope, iPhone can create a beautiful wallpaper out of a photo.",
        imageAssets: ["K-1", "K-2", "K-3", "K-4", "K-5", "K-6"]
    ),
    .init(
        id: "Collections",
        description: "A collection of favorite wallpapers for iPhone.",
        imageAssets: ["C-1", "C-2", "C-3"]
    )
]
