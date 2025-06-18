/*
    Created by Huisoo on 6/9/25.
*/

///
/// .editingChanged 이벤트를 이용하여 글자수를 제한하는 방식
///
/// 이 방식은 문자열의 길이만으로 글자 수를 제한하는 경우에 가장 마지막 글자의 입력 후 계속 입력하면 마지막 글자가 바뀌는 것을 보완하기 위한 방식입니다.
/// 기본 구조는 문자열의 길이를 확인 한 후 문자열을 저장한 후에 글자 수가 넘어간 경우 다시 덮어 씌우는 방식입니다.
///
/// - Note: 일반적으로 사용하는 입력 후 문자열의 길이를 자르는 방식의 경우에는 문자열 중간에 입력하면 가장 마지막 글자가 사라지고 입력이 되어버리기 때문에 이전 문자열을 저장하는 방식 채용
/// - Attention: 문자열 중간에서 입력 시 입력 포인트의 위치가 강제로 가장 뒤로 이동되는 현상 존재
/// - SeeAlso: https://hello-developer.tistory.com/88#:~:text=%40objc%20func%20textDidChange%28noti%3A%20NSNotification%29%20,
///

import UIKit

class UsingEventViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!

    private var text: String?

    private let maxLength = 5 // 글자 수 제한

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc private func editingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        if text.count > maxLength {
            DispatchQueue.main.async {
                sender.text = self.text
            }
        } else {
            self.text = text
        }
    }
}
