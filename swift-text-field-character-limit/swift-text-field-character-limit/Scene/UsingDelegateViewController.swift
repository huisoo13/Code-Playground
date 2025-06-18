/*
    Created by Huisoo on 2025-06-18
*/

///
/// textField(_:shouldChangeCharactersIn:replacementString:)를 이용하여 글자수를 제한하는 방식
///
/// 이 방식은 문자열의 길이만으로 글자 수를 제한하는 경우에 가장 마지막 글자의 종성이 입력되지 않는 현상을 좀 더 고차원적인 방법으로 해결하기 위해 작성된 방식입니다.
/// 기본 구조는 자음과 모음의 조합을 직접 확인하여 입력 여부를 판단하는 방식입니다.
///
/// - Attention: 자동 완성이나 번역 등 사용자가 직접 키보드를 조작하여 입력하는 방식이 아닌 경우에  false을 반환하였지만 입력이 적용되는 현상이 존재하며, 천지인 키보드 배열에서는 사용 불가
/// - SeeAlso: https://zartt.tistory.com/36
///

import UIKit

class UsingDelegateViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    private var isUserTyping: Bool = false  // 사용자가 입력을 했는지 확인하는 플래그
    private var isChangedSelectionByUser: Bool = false  // 사용자가 TextField 입력 포인트를 변경 했는지 확인하는 플래그
    
    private let maxLength = 5 // 글자 수 제한

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        textField.delegate = self
    }
}

extension UsingDelegateViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isUserTyping = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 입력 가능 여부 확인
        let result: Bool = {
            // 백스페이스
            if string.isEmpty {
                return true
            }
            
            let originText = textField.text ?? "" // 입력 전 텍스트
            let changedText = (originText as NSString).replacingCharacters(in: range, with: string) // 입력 후 텍스트
            
            // 글자수 제한
            if changedText.unicodeScalars.count <= maxLength {
                return true
            }
            
            // 입력 후 글자 수 제한을 넘는 경우, 한글 일 때
            if string.isHangul {
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
            }
            
            return false
        }()
        
        isUserTyping = result
        
        return result
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 입력 포인트 변경이 생김
        isChangedSelectionByUser = !isUserTyping  // 타이핑 중이 아닌 경우에만 체크
        isUserTyping = false    // 타이핑 종료
    }
}

extension String {
    // 한글인지 확인
    var isHangul: Bool {
        return "\(self)".range(of: "\\p{Hangul}", options: .regularExpression) != nil
    }
    
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
