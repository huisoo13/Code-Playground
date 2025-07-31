//
//  ViewModel.swift
//  swift-mvvm-pattern
//
//  Created by Huisoo on 7/31/25.
//

import Foundation

class ViewModel {
    
    var model: Observable<Model>
    
    init(model: Model) {
        self.model = Observable(model)
    }
    
    func updateText(_ text: String) {
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(1))
            model.value.text = text
        }
    }
    
    func updateNumber(_ nunmber: Int) {
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(1))
            model.value.number = nunmber
        }
    }
}
