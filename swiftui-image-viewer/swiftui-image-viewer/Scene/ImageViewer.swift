//
//  ImageViewer.swift
//  swiftui-image-viewer
//
//  Created by Huisoo on 9/24/25.
//

import SwiftUI
import Kingfisher

struct ImageViewer: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var items: [String: [String]]   // 외부 주입 데이터
    @Binding var focus: String?
    
    private var images: [String] {
        items.sorted(by: { $0.key < $1.key }).flatMap({ $0.value })
    }
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .black, location: 0.00),
                    Gradient.Stop(color: Color(red: 0.2, green: 0.2, blue: 0.2), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .ignoresSafeArea(.all)
            
            // Image
            TabView(selection: $focus) {
                ForEach(images, id: \.self) { image in
                    ZoomableScrollView() {
                        KFImage(URL(string: image))
                            .resizable()
                            .scaledToFit()           // 원본 비율 유지
                    }
                    .tag(image)
                    .ignoresSafeArea(.all)
                    .onAppear {
                        if let last = images.last, last == image {
                            // load more code...
                            print("load more...")
                        }
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .automatic))
            .ignoresSafeArea(.all)
            
            // Navigation
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    @Previewable @State var items: [String: [String]] = [:]
    @Previewable @State var focus: String? = nil
    
    ImageViewer(items: $items, focus: $focus)
}
