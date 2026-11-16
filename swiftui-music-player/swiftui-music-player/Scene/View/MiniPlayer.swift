//
//  MiniPlayer.swift
//  swiftui-music-player
//
//  Created by Huisoo on 11/16/26.
//

import SwiftUI

struct MiniPlayer: View {
    
    var namespace: Namespace.ID
    
    var body: some View {
        ///Dummy Mini Player
        HStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 5)
                .overlay {
                    Color.red
                }
                .clipShape(.rect(cornerRadius: 5))
                .matchedGeometryEffect(id: "Image", in: namespace)
                .frame(width: 30, height: 30)

            VStack(alignment: .leading, spacing: 2) {
                Text("Resident Evil 2")
                    .font(.callout)
                
                Text("Capcom, Co., Ltd.")
                    .font(.caption)
            }
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image(systemName: "play.fill")
                    .font(.title3)
                    .padding(.horizontal, 5)
            }
        }
        .foregroundStyle(Color.primary)
        .padding(.leading, 20)
        .padding(.trailing, 15 )
    }
}

#Preview {
    ContentView()
        .colorScheme(.dark)
}
