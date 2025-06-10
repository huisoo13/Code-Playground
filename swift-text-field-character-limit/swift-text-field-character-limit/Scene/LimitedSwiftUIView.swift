import SwiftUI

struct LimitedSwiftUIView: View {
    
    // 이 뷰 내부에서 텍스트를 관리하기 위한 상태 변수
    @State private var text: String = ""
    
    // 외부에서 전달받을 글자 수 제한
    let limit: Int
    
    // 텍스트가 변경될 때마다 외부(UIKit)로 변경된 텍스트를 전달하기 위한 클로저
    var onTextChanged: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // SwiftUI의 기본 TextField
            TextField("여기에 입력하세요...", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onChange(of: text) { newValue in
                    // 글자 수가 제한을 초과하면
                    if newValue.count > limit {
                        // 제한된 글자 수만큼 텍스트를 자릅니다.
                        let truncatedText = String(newValue.prefix(limit))
                        // 잘린 텍스트로 내부 상태를 업데이트합니다.
                        self.text = truncatedText
                        // 변경된 최종 텍스트를 콜백으로 전달합니다.
                        onTextChanged(truncatedText)
                    } else {
                        // 제한을 넘지 않으면 변경된 텍스트를 그대로 콜백으로 전달합니다.
                        onTextChanged(newValue)
                    }
                }
            
            // 현재 글자 수를 표시하는 UI
            Text("글자 수: \(text.count) / \(limit)")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .foregroundColor(text.count > limit ? .red : .secondary)
        }
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    LimitedSwiftUIView(limit: 20) { text in
        print("Preview: \(text)")
    }
    .padding()
}