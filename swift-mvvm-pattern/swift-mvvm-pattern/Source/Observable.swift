//
//  Observable.swift
//  swift-mvvm-pattern
//
//  Created by Huisoo on 7/31/25.
//

import Foundation

class Observable<T> {
    struct Observer {
        weak var owner: AnyObject?
        let block: (T) -> Void
    }
    
    private var observers: [Observer] = []
    
    var value: T {
        didSet { dispatch() }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func addObserver(on owner: AnyObject, block: @escaping (T) -> Void) {
        // 중복 제거
        observers.removeAll { $0.owner === owner }

        observers.append(Observer(owner: owner, block: block))
        block(value)
    }
    
    func removeObserver(_ owner: AnyObject) {
        observers = observers.filter { $0.owner !== owner }
    }
    
    private func dispatch() {
        // 옵저버 정리
        observers = observers.filter { $0.owner != nil }

        for observer in observers {
            observer.block(value)
        }
    }
}
