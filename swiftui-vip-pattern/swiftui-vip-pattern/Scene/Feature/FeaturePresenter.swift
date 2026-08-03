//
//  FeaturePresenter.swift
//  swiftui-vip-pattern
//
//  Created by Huisoo on 8/3/26.
//

import SwiftUI

@Observable
class FeaturePresenter {
    enum State {
        case idle
        case success
        case failure
        case up
        case down
    }
    
    private(set) var chance: Int = 10
    private(set) var answer: String = String(Int.random(in: 1...100))
    private(set) var submission: String = ""
    
    private(set) var state: State = .idle
    
    func onChanged(submission: String) {
        self.submission = submission
    }
    
    func onSubmit() {
        guard state != .success, state != .failure else { return }
        
        chance -= 1
        
        switch (Int(answer), Int(submission)) {
        case let (answer?, submission?) where answer < submission:
            if chance == 0 {
                state = .failure
                return
            }
            
            state = .down
        case let (answer?, submission?) where answer > submission:
            if chance == 0 {
                state = .failure
                return
            }

            state = .up
        default:
            state = .success
        }
    }
    
    func reset() {
        chance = 10
        answer = String(Int.random(in: 1...100))
        submission.removeAll()
        
        state = .idle
    }
}
