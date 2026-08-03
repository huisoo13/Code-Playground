//
//  FeatureView.swift
//  swiftui-vip-pattern
//
//  Created by Huisoo on 8/3/26.
//

import SwiftUI

struct FeatureBuilder {
    @MainActor
    @ViewBuilder
    static func build() -> FeatureView {
        let presenter = FeaturePresenter()
        FeatureView(presenter: presenter, interactor: FeatureInteractor(presenter: presenter))
    }
}

struct FeatureView: View {
    @State private var presenter: FeaturePresenter
    private let interactor: FeatureInteractor
    
    init(presenter: FeaturePresenter, interactor: FeatureInteractor) {
        self._presenter = State(initialValue: presenter)
        self.interactor = interactor
    }
    
    private var submission: Binding<String> {
        Binding(
            get: { presenter.submission },
            set: { interactor.onChanged(submission: $0) }
        )
    }
    
    var body: some View {
        VStack {
            Text("Number Up & Down")
            
            TextField("1 ~ 100 사이의 숫자", text: submission)
                .font(Font.system(size: 14))
                .frame(height: 14)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.clear)
                        .stroke(Color.gray, lineWidth: 1)
                }
                .onSubmit {
                    interactor.onSubmit()
                }
            
            HStack {
                switch presenter.state {
                case .idle:
                    Text("숫자를 맞춰보세요.")
                case .success:
                    Text("정답입니다!")
                case .failure:
                    Text("실패했습니다...")
                case .up:
                    Text("입력한 숫자보다 높습니다.")
                case .down:
                    Text("입력한 숫자보다 낮습니다.")
                }
                
                Text("남은 기회: \(presenter.chance)")
            }
            Button {
                interactor.reset()
            } label: {
                Text("다시하기")
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    FeatureBuilder.build()
}
