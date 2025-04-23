//
//  AppError.swift
//  swift-strategy-pattern
//
//  Created by 정희수 on 4/21/25.
//

import UIKit

enum AppError: Error {
    case network
    case invalidInput(String)
    case unauthorized
    case unknown
}

enum ErrorHandlingLevel {
    case all
    case alert
    case logging
    case none
}

// MARK: - Strategy

protocol ErrorHandlingStrategy {
    func handle(_ error: AppError)
}

final class AlertErrorHandler: ErrorHandlingStrategy {
    weak var target: UIViewController?
    init(target: UIViewController? = nil) {
        self.target = target
    }
    
    func handle(_ error: AppError) {
        let message: String

        switch error {
        case .network:
            message = "인터넷 연결이 불안정합니다."
        case .invalidInput(let reason):
            message = reason
        case .unauthorized:
            message = "세션이 만료되었습니다."
        case .unknown:
            message = "알 수 없는 오류가 발생했습니다."
        }

        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "확인", style: .default))
        target?.present(alert, animated: true)
    }
}

final class LoggingErrorHandler: ErrorHandlingStrategy {
    func handle(_ error: AppError) {
        print("Error: \(error)")
    }
}

final class CompositeErrorHandler: ErrorHandlingStrategy {
    private let handlers: [ErrorHandlingStrategy]

    init(_ handlers: [ErrorHandlingStrategy]) {
        self.handlers = handlers
    }

    func handle(_ error: AppError) {
        handlers.forEach { $0.handle(error) }
    }
}
