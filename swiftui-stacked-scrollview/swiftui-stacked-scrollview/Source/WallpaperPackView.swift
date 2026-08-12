//
//  WallpaperPackView.swift
//  swiftui-stacked-scrollview
//
//  Created by Huisoo on 8/12/26.
//

import SwiftUI

struct WallpaperPackView: View {
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 32) {
                ForEach(packs) { pack in
                    WallpaperPackRowView(pack: pack)
                }
            }
        }
        .safeAreaPadding(16)
    }
}

struct WallpaperPackRowView: View {
    var pack: WallpaperPack
    
    @State private var toggle: Bool = false

    var body: some View {
        WallpaperStackView(title: pack.title, description: pack.description, trigger: toggle) {
            ForEach(pack.imageAssets, id: \.self) { wallpaper in
                Rectangle()
                    .foregroundStyle(Color(wallpaper)) // 이미지 파일 대신 컬러로 대체
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay {
                        // 실제 이미지 넣는 곳
                        /*
                        Image(wallpaper)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                         */
                    }
            }
        } buttonView: {
            Button {
                toggle.toggle()
            } label: {
                if toggle {
                    Image(systemName: "xmark")
                        .frame(height: 24)
                } else {
                    Text("GET")
                }
            }
            .fontWeight(.medium)
            .buttonStyle(.borderedProminent)
            .tint(.gray.opacity(0.35))
            .buttonSizing(.flexible)
            .frame(maxWidth: toggle ? 20 : 80)
        }

    }
}

#Preview {
    WallpaperPackView()
        .preferredColorScheme(.dark)
}
