//
//  ContentView.swift
//  swiftui-foundatioin-models-framework
//
//  Created by Huisoo on 7/29/25.
//

import SwiftUI
import FoundationModels

struct ContentView: View {
    
    @State private var wishListItem: [WishListItem] = []
    @State private var isGenerating: Bool = false
    
    var body: some View {
        List(wishListItem) { item in
            Text(item.text)
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(
                    "Generate wish list",
                    systemImage: "cart.fill.badge.plus"
                ) {
                    generateShoppingList()
                }
                .disabled(isGenerating)
            }
        }
    }
    
    private func generateShoppingList() {
        let prompt = "Create 15 wish list items"
        Task {
            do {
                let session = LanguageModelSession()
                let response = session.streamResponse(
                    generating: [WishListItem].self
                ) {
                    prompt
                }
                isGenerating = true
                for try await chunk in response {
                    self.wishListItem = chunk.compactMap {
                        guard let id = $0.id, let task = $0.text else {
                            return nil
                        }
                        return WishListItem(id: id, text: task)
                    }
                }
                isGenerating = false
            } catch {
                print(error.localizedDescription)
                isGenerating = false
            }
        }
    }
}

#Preview {
    ContentView()
}

@Generable(description: "Generate for a toy wish list")
struct WishListItem: Identifiable {
    let id: String
    
    @Guide(description: "상품명")
    let text: String
}
