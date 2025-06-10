//
//  ViewController.swift
//  swift-text-field-character-limit
//
//  Created by 정희수 on 6/9/25.
//
// https://hello-developer.tistory.com/88#:~:text=%40objc%20func%20textDidChange%28noti%3A%20NSNotification%29%20,


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    let characterLimit = 5 // 글자 수 제한
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
        
        if text.count > characterLimit {
            DispatchQueue.main.async {
                sender.text = self.tempString
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        tempString = textField.text ?? ""
        return true
    }
}
