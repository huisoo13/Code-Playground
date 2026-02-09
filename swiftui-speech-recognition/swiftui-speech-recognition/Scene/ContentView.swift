//
//  ContentView.swift
//  swiftui-speech-recognition
//
//  Created by Huisoo on 2/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var speechManager = SpeechManager()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // 텍스트 출력 영역
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                    
                    ScrollView {
                        Text(speechManager.transcript)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal)
                
                // 제어 버튼
                Button(action: {
                    if speechManager.isRecording {
                        speechManager.stopTranscribing()
                    } else {
                        speechManager.startTranscribing()
                    }
                }) {
                    VStack {
                        Image(systemName: speechManager.isRecording ? "stop.fill" : "mic.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .frame(width: 64, height: 64)
                            .padding(16)
                            .background(speechManager.isRecording ? Color.red : Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                }
                .padding(.bottom, 32)
            }
            .navigationTitle("음성 인식")
            .onAppear {
                Task {
                    do {
                        try await speechManager.prepareTranscribing()
                    } catch let error as SpeechManager.SpeechError {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
