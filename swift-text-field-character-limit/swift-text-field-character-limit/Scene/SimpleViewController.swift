//
//  SimpleViewController.swift
//  swift-text-field-character-limit
//
//  Created by 정희수 on 6/11/25.
//
// https://hello-developer.tistory.com/88#:~:text=%40objc%20func%20textDidChange%28noti%3A%20NSNotification%29%20,

/**
 비교적 쉽게 처리하는 로직
 */

import UIKit

class SimpleViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var tempString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc private func editingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let maxLength = 5 // 글자 수 제한
        
        if text.count > maxLength {
            DispatchQueue.main.async {
                sender.text = self.tempString
            }
        }
    }
}

extension SimpleViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        tempString = text
        
        return true
    }
}
