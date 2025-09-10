//
//  ContentView.swift
//  swiftui-multi-target-project
//
//  Created by Huisoo on 9/10/25.
//

import SwiftUI

struct ContentView: View {
    
    let test = Bundle.main.infoDictionary!["test"] as! String
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(test)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
