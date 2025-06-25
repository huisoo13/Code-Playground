//
//  Actor.swift
//  swift-concurrency
//
//  Created by Huisoo on 6/20/25.
//

import Foundation

actor Actor {
    private var value: Int = 0
    
    func increment() async {
        print(#function)
        value += 1
    }
    
    func decrement() async {
        print(#function)
        value -= 1
    }
    
    func printA() async {
        try? await Task.sleep(for: .seconds(1))
        print("A", Date().timeIntervalSince1970)
    }
    
    func printB() async {
        try? await Task.sleep(for: .seconds(2))
        print("B", Date().timeIntervalSince1970)
    }
    
    func getValue() async -> Int {
        print(#function)
        return value
    }
    
    @MainActor
    func closure(_ closure: () -> Void) {
        closure()
    }
}
