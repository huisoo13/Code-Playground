//
//  ContentView.swift
//  swiftui-image-viewer
//
//  Created by Huisoo on 9/24/25.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    private let padding: CGFloat = 8
    private let spacing: CGFloat = 2
    private let columns = 4
    private var gridItems: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: self.spacing),
            count: self.columns
        )
    }
    private var images: [String] {
        items.sorted(by: { $0.key < $1.key }).flatMap({ $0.value })
    }
    
    @State private var items: [String: [String]] = [:]
    @State private var focus: String? = nil
    @State private var isPresented: Bool = false

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if !items.isEmpty {
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(Array(items.keys).sorted(by: { $0 < $1 }), id: \.self) { key in
                                    VStack(spacing: 8) {
                                        sectionHeaderView(key)
                                        sectionGridView(key)
                                    }
                                }
                            }
                            .padding(.vertical, 16)
                            .padding(.horizontal, 8)
                        }
                        // 뷰어에서 보고있는 이미지에 맞게 스크롤 조정하는 modifier
                        .onChange(of: focus ?? "") { _, newValue in
                            guard !newValue.isEmpty else { return }
                            DispatchQueue.main.async {
                                withAnimation(.easeInOut) {
                                    proxy.scrollTo(newValue, anchor: .center)
                                }
                            }
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("Do not have any images yet")
                            .font(.headline)
                            .foregroundStyle(Color.black.secondary)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            let dummy = makeDummyData()
            self.items = dummy
        }
        .fullScreenCover(isPresented: $isPresented, onDismiss: {
            isPresented = false
        }, content: {
            ImageViewer(items: $items, focus: $focus)
        })
    }
    
    // MARK: - ViewBuilder
    
    @ViewBuilder
    private func sectionHeaderView(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func sectionGridView(_ title: String) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading, spacing: spacing) {
            ForEach(items[title] ?? [], id: \.self) { item in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(Color.black.tertiary)
                    
                    KFImage(URL(string: item))
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(1, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .id(item)
                .onTapGesture {
                    focus = item
                    isPresented = true
                }
                .onAppear {
                    if let last = images.last, last == item {
                        // load more code...
                        print("load more...")
                    }
                }
            }
        }
    }
    
    // MARK: - Dummy
    func makeDummyData() -> [String: [String]] {
        let data: [String: [String]] = [
            "Sun": [
                "https://picsum.photos/id/96/500/500",
                "https://picsum.photos/id/87/500/500",
                "https://picsum.photos/id/77/500/500",
                "https://picsum.photos/id/25/500/500",
                "https://picsum.photos/id/23/500/500",
                "https://picsum.photos/id/67/500/500",
                "https://picsum.photos/id/26/500/500"
            ],
            "Banana": [
                "https://picsum.photos/id/99/500/500",
                "https://picsum.photos/id/31/500/500",
                "https://picsum.photos/id/71/500/500"
            ],
            "Kite": [
                "https://picsum.photos/id/28/500/500",
                "https://picsum.photos/id/91/500/500",
                "https://picsum.photos/id/0/500/500",
                "https://picsum.photos/id/45/500/500",
                "https://picsum.photos/id/43/500/500",
                "https://picsum.photos/id/93/500/500",
                "https://picsum.photos/id/35/500/500",
                "https://picsum.photos/id/40/500/500"
            ],
            "Orange": [
                "https://picsum.photos/id/48/500/500",
                "https://picsum.photos/id/14/500/500"
            ],
            "Flower": [
                "https://picsum.photos/id/62/500/500",
                "https://picsum.photos/id/15/500/500",
                "https://picsum.photos/id/30/500/500",
                "https://picsum.photos/id/29/500/500",
                "https://picsum.photos/id/33/500/500",
                "https://picsum.photos/id/3/500/500",
                "https://picsum.photos/id/85/500/500",
                "https://picsum.photos/id/8/500/500"
            ],
            "Dog": [
                "https://picsum.photos/id/5/500/500",
                "https://picsum.photos/id/98/500/500",
                "https://picsum.photos/id/52/500/500",
                "https://picsum.photos/id/1/500/500",
                "https://picsum.photos/id/89/500/500",
                "https://picsum.photos/id/16/500/500",
                "https://picsum.photos/id/12/500/500",
                "https://picsum.photos/id/70/500/500"
            ],
            "Piano": [
                "https://picsum.photos/id/84/500/500",
                "https://picsum.photos/id/6/500/500",
                "https://picsum.photos/id/32/500/500",
                "https://picsum.photos/id/34/500/500"
            ],
            "Island": [
                "https://picsum.photos/id/49/500/500",
                "https://picsum.photos/id/65/500/500",
                "https://picsum.photos/id/79/500/500",
                "https://picsum.photos/id/73/500/500",
                "https://picsum.photos/id/63/500/500"
            ],
            "Notebook": [
                "https://picsum.photos/id/69/500/500",
                "https://picsum.photos/id/17/500/500",
                "https://picsum.photos/id/61/500/500",
                "https://picsum.photos/id/92/500/500"
            ],
            "Mountain": [
                "https://picsum.photos/id/90/500/500",
                "https://picsum.photos/id/36/500/500",
                "https://picsum.photos/id/56/500/500"
            ]
        ]
        return data
    }
}

#Preview {
    ContentView()
}
