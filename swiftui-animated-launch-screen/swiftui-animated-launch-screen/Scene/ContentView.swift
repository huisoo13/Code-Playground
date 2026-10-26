//
//  ContentView.swift
//  swiftui-animated-launch-screen
//
//  Created by Huisoo on 10/26/26.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @AppStorage("isOnboardingCompleted") private var isOnboardingComplete = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .splashSreen(config: .init(), showOnboarding: !isOnboardingComplete) {
            OnboardingView()
        }
    }
}


struct OnboardingView: View {
    @AppStorage("isOnboardingCompleted") private var isOnboardingComplete = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Discover Your favourite\nApple products")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            SignInWithAppleButton { _ in
            
            } onCompletion: { _ in
                dismiss()
                isOnboardingComplete = true
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .clipShape(.capsule)
            
            Text("By continuing, you agree to our\nTerms of Service and Privacy Policy")
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundStyle(.primary.secondary)
        }
        .padding(.horizontal, 5)
        .padding(15)
    }
}


#Preview {
    ContentView()
}
