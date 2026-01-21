import AppStorageContainerMacro
import Observation

#error("@Observable 추가 시 didSet 호출 안됨. 빼면 문제 없지만 UI 갱신이 안되므로 해결 방법 강구 필요")
@AppStorageContainer
@Observable
class TestObject1 {
    var number: Int = 0
}

@Observable
class TestObject2 {
    private var storageFromMacro: StorageFromMacro
    init() {
        storageFromMacro = StorageFromMacro()
        number = storageFromMacro.number
    }
    
    var number: Int = 0 {
        didSet {
            storageFromMacro.number = self.number
            print("number update")
        }
    }
    
    struct StorageFromMacro {
        @AppStorage("number_app_storage") var number: Int = 0
    }
}
