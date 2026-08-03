//
//  FeatureInteractor.swift
//  swiftui-vip-pattern
//
//  Created by Huisoo on 8/3/26.
//

import SwiftUI

class FeatureInteractor {
    private let presenter: FeaturePresenter
    
    init(presenter: FeaturePresenter) {
        self.presenter = presenter
    }
    
    func onChanged(submission: String) {
        presenter.onChanged(submission: submission)
    }
    
    func onSubmit() {
        presenter.onSubmit()
    }
    
    func reset() {
        presenter.reset()
    }
}
