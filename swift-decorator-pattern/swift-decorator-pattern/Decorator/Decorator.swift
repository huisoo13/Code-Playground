//
//  Decorator.swift
//  swift-decorator-pattern
//
//  Created by 정희수 on 4/16/25.
//
// 참고 글: https://en.wikipedia.org/wiki/Decorator_pattern

import Foundation

// MARK: - Component Interface

protocol Maratang {
    func cost() -> Int
    func description() -> String
}


// MARK: - Concrete Component

class MildMaratang: Maratang {
    func cost() -> Int {
        return 1000
    }
    
    func description() -> String {
        return "마라탕 순한 맛"
    }
}

class LessSpicyMaratang: Maratang {
    func cost() -> Int {
        return 1100
    }
    
    func description() -> String {
        return "마라탕 조금 매운 맛"
    }
}

class SpicyMaratang: Maratang {
    func cost() -> Int {
        return 1200
    }
    
    func description() -> String {
        return "마라탕 매운맛"
    }
}

// MARK: - Decorator

protocol Topping: Maratang {
    var decorated: Maratang { get set }
    init(decorated: Maratang)
    
    func removing<T: Topping>(_ decoratorType: T.Type) -> Maratang
    func contains<T: Topping>(_ decoratorType: T.Type) -> Bool
}

extension Topping {
    func removing<T: Topping>(_ decoratorType: T.Type) -> Maratang {
        // 마지막으로 한 토핑이 T인 경우, 토핑 하기 전 값을 return
        if type(of: self) == decoratorType {
            return decorated
        }
        
        // 토핑 하기 전 값이 T인 경우, 그 전 값을 decorated로 전환
        if let topping = decorated as? T {
            return Self.init(decorated: topping.decorated)
        }
        
        // 이전에 토핑한 값이 Topping인 경우, 재귀
        if let topping = decorated as? Topping {
            return Self.init(decorated: topping.removing(T.self))
        }
                
        // 모두 해당하지 않는 경우, Topping이 아니므로 return self
        return self
    }
    
    func contains<T: Topping>(_ decoratorType: T.Type) -> Bool {
        // 마지막으로 한 토핑이 T인 경우, true
        if type(of: self) == decoratorType {
            return true
        }
        
        // 토핑 하기 전 값이 T인 경우, true
        if type(of: decorated) == decoratorType {
            return true
        }
        
        // 이전에 토핑한 값이 Topping인 경우, 재귀
        if let topping = decorated as? Topping {
            return topping.contains(T.self)
        }
                
        // 모두 해당하지 않는 경우, false
        return false
    }
}

// MARK: - Concrete Decorator

class Noodles: Topping {
    var decorated: Maratang
    required init(decorated: Maratang) {
        self.decorated = decorated
    }
    
    func cost() -> Int {
        return decorated.cost() + 200
    }
    
    func description() -> String {
        return decorated.description() + " + 면"
    }
}

class Meat: Topping {
    var decorated: Maratang
    required init(decorated: Maratang) {
        self.decorated = decorated
    }
    
    func cost() -> Int {
        return decorated.cost() + 300
    }
    
    func description() -> String {
        return decorated.description() + " + 고기"
    }
}

class Vegetable: Topping {
    var decorated: Maratang
    required init(decorated: Maratang) {
        self.decorated = decorated
    }
    
    func cost() -> Int {
        return decorated.cost() + 400
    }
    
    func description() -> String {
        return decorated.description() + " + 채소"
    }
}
