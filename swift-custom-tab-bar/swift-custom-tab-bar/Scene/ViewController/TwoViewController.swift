//
//  TwoViewController.swift
//  Swift-Playground
//
//  Created by 정희수 on 5/21/25.
//

import UIKit

class TwoViewController: UIViewController {

    var webView: WKWebView!
    var reloader: WebViewReloader!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray5
        
        webView = WKWebView()
        view.addSubview(webView)
        
        reloader = WebViewReloader(webView, triggers: .dateExpired)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        reloader.reloadWebViewIfNeeded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}

extension TwoViewController: RootViewDelegate {
    func rootViewController(_ viewController: UIViewController) {
        viewController.title = "TAB 2"
    }
}

import WebKit

class WebViewReloader {
    
    struct Trigger: OptionSet {
        let rawValue: Int

        static let dateExpired = Trigger(rawValue: 1 << 0)
        static let profileUpdated = Trigger(rawValue: 1 << 1)
        static let topicUpdated = Trigger(rawValue: 1 << 2)
    }
    
    enum Option {
        case requiresAnyOf  // 조건이 하나라도 만족하는 경우
        case requiresAllOf  // 조건이 모두 만족하는 경우
        // case requiresAtLeast(_ count: Int)
    }
    
    private var current: Trigger = []
    private var lastLoadWebViewDate: Date = Date()

    // MARK: - init
    
    private let triggers: Trigger
    private let option: Option
    private let webView: WKWebView
    init(_ target: WKWebView, triggers: Trigger, option: Option = .requiresAnyOf) {
        self.webView = target
        self.triggers = triggers
        self.option = option
        
        setupObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public
    @MainActor
    func reloadWebViewIfNeeded() {
        switch option {
        case .requiresAnyOf:
            guard !current.intersection(triggers).isEmpty else {
                print("Trigger not satisfied")
                return
            }

            reload()
        case .requiresAllOf:
            guard current.contains(triggers) else {
                print("Trigger not satisfied")
                return
            }
            
            reload()
        }
    }

    // MARK: - Private
    
    private func setupObserver() {
        // willEnterForeground
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadWebViewIfNeededWhenWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        // didUpdateProfile
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateProfile),
            name: .didUpdateProfileNotification,
            object: nil
        )
        
        // didUpdateTopic
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTopic),
            name: .didUpdateTopicNotification,
            object: nil
        )
    }
     
    @MainActor
    @objc private func updateProfile() {
        current.insert(.profileUpdated)
    }
    
    @MainActor
    @objc private func updateTopic() {
        current.insert(.topicUpdated)
    }
    
    @MainActor
    private func expireDate() {
        let currentDate = Date()
        let lastDate = lastLoadWebViewDate
        
        let calendar = Calendar.current
        
        // 같은 날인지 확인
        guard !calendar.isDate(lastDate, equalTo: currentDate, toGranularity: .day) else {
            print("Same day, no need to reload web view")
            return
        }
        
        // 마지막 시간 저장
        lastLoadWebViewDate = Date()
        current.insert(.dateExpired)
    }
    
    @MainActor
    @objc private func reloadWebViewIfNeededWhenWillEnterForeground() {
        expireDate()
        
        guard webView.window != nil else {
            print("WebView is not visible")
            return
        }
        
        reloadWebViewIfNeeded()
    }
    
    @MainActor
    private func reload() {
        print("Reload triggered by: \(current.intersection(triggers))")
        webView.reload()
        current = []
    }
}

extension Notification.Name {
    static let didUpdateProfileNotification = Notification.Name("didUpdateProfileNotification")
    static let didUpdateTopicNotification = Notification.Name("didUpdateTopicNotification")
}
