//
//  ViewController.swift
//  swift-text-field-character-limit
//
//  Created by 정희수 on 6/9/25.
//
// https://zartt.tistory.com/36

/**
 UITextFieldDelegate를 이용하여 자음과 모음의 조합을 직접 컨트롤해서 처리하는 로직
 */

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var isUserTyping: Bool = false  // 사용자가 입력을 했는지 확인하는 플래그
    var isChangedSelectionByUser: Bool = false  // 사용자가 TextField 입력 포인트를 변경 했는지 확인하는 플래그

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        textField.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isUserTyping = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 입력 가능 여부 확인
        let result: Bool = {
            let maxLength = 5 // 글자 수 제한
            let originText = textField.text ?? "" // 입력 전 텍스트
            let changedText = (originText as NSString).replacingCharacters(in: range, with: string) // 입력 후 텍스트
            
            // 글자수 제한
            if changedText.unicodeScalars.count <= maxLength {
                return true
            }
            
            // 입력 후 글자 수 제한을 넘는 경우

            // 직접 커서를 옮긴 경우 (무조건 새로운 글자가 생기기 때문에)
            if isChangedSelectionByUser {
                return false
            }

            let previousCharacter = range.location > 0 ? (originText as NSString).substring(with: NSRange(location: range.location - 1, length: 1)) : "" // 입력 포인트 위치 글자 가져오기
            let separatedCharacters = previousCharacter.decomposedStringWithCanonicalMapping.unicodeScalars.map{ String($0) } // 글자를 자음과 모음으로 분리
                    
            if separatedCharacters == ["\0"] { // 커서가 가장 앞에 있는 경우
                return false
            }
            
            if separatedCharacters.count == 1    // 분리한 글자가 자음 또는 모음이 1개 있고
                && separatedCharacters[0].isConsonant   // 분리한 글자가 자음 일 때
                && !string.isConsonant { // 입력한 글자가 모음인지 확인
                return true
            }
            
            if separatedCharacters.count == 2    // 분리한 글자가 자음과 모음의 조합이고
                && !string.isConsonant  // 입력한 글자가 모음 일 때
                && separatedCharacters[1].canDiphthong(with: string) { // 이중 모음을 만들 수 있는지 확인
                return true
            }
            
            if separatedCharacters.count == 2    // 분리한 글자가 자음과 모음의 조합이고
                && string.isConsonant { // 입력한 글자가 자음인지 확인
                return true
            }
            
            if separatedCharacters.count == 3    // 분리한 글자가 받침이 있고
                && string.isConsonant  // 입력한 글자가 자음 일 때
                && separatedCharacters[2].canDoubleConsonant(with: string)  { // 겹받침을 추가 할 수 있는지 확인
                return true
            }
            
            return false
        }()
        
        isUserTyping = result
        
        // 글자 수 초과 시 진동 피드백
        if !result {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        
        return result
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 입력 포인트 변경이 생김
        isChangedSelectionByUser = !isUserTyping  // 타이핑 중이 아닌 경우에만 체크
        isUserTyping = false    // 타이핑 종료
    }
}

extension String {
    // 글자가 자음인지 체크
    var isConsonant: Bool {
        guard let scalar = UnicodeScalar(self)?.value else {
            return false
        }
        
        let consonantScalarRange: ClosedRange<UInt32> = 0x3131...0x314E
        return consonantScalarRange ~= scalar
    }
    
    // 겹받침이 되는지 확인
    func canDoubleConsonant(with consonant: String) -> Bool {
        guard let scalar = UnicodeScalar(self)?.value else { return false }

        switch scalar {
        case 0x11A8: // ᆨ
            return ["ㅅ"].contains(consonant)
        case 0x11AB: // ᆫ
            return ["ㅈ", "ㅎ"].contains(consonant)
        case 0x11AF: // ᆯ
            return ["ㄱ", "ㅁ", "ㅂ", "ㅅ", "ㅌ", "ㅍ", "ㅎ"].contains(consonant)
        case 0x11B8: // ᆸ
            return ["ㅅ"].contains(consonant)
        default:
            return false
        }
    }
    
    // 이중 모음이 되는지 확인
    func canDiphthong(with vowel: String) -> Bool {
        guard let scalar = UnicodeScalar(self)?.value else { return false }

        switch scalar {
        case 0x1169: // ㅗ
            return ["ㅏ", "ㅐ", "ㅣ"].contains(vowel)
        case 0x116C: // ㅜ
            return ["ㅓ", "ㅔ", "ㅣ"].contains(vowel)
        case 0x116E: // ㅡ
            return ["ㅣ"].contains(vowel)
        default:
            return false
        }
    }
}
