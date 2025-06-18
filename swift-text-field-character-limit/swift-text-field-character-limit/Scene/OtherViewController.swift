/*
    Created by Huisoo on 6/9/25.
*/

///
/// 글자 수를 제한하는 방식이 아닌 시각적 또는 촉각적 피드백을 제공하는 방식
///
/// 이 방식은 문자열의 길이가 조건을 만족하지 않는 경우 색상을 변경하거나 햅틱 등을 이용하여 피드백을 제공하는 방식입니다.
///
/// - Note: 앞서 사용한 글자 수를 제한하는 방식의 경우에 사용자의 조작 감성을 해치는 케이스가 존재하여 최종적으로 선택한 방식
///

import UIKit

class OtherViewController: UIViewController {

    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var counterLabel: UILabel!
    
    private let maxLength = 5 // 글자 수 제한

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        containerView.layer.cornerRadius = 8
        containerView.layer.borderColor = UIColor.systemGray5.cgColor
        containerView.layer.borderWidth = 1
        
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        counterLabel.text = "0 / \(maxLength)"
    }
    
    @objc private func editingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        updateLabel(text)
    }

    private func updateLabel(_ string: String) {
        counterLabel.text = "\(string.count) / \(maxLength)"
        counterLabel.textColor = .secondaryLabel
        
        if string.count > maxLength {
            feedback()
        }
    }
    
    private func feedback() {
        counterLabel.textColor = .systemRed
        haptic()
        animation()
    }
    
    private func haptic() {
        DispatchQueue.main.async {
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        }
    }
    
    private func animation() {
        let duration: TimeInterval = 0.5
        let repeatCount: Float = 2
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration / 10
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: counterLabel.center.x - 2, y: counterLabel.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: counterLabel.center.x + 2, y: counterLabel.center.y))
        counterLabel.layer.add(animation, forKey: "shake")
    }
}
