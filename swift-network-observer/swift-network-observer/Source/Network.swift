/*
    Created by Huisoo on 2025-06-19
*/

import Network

@MainActor
class Network {
    static let shared = Network()
    private init() { }
    
    private let nwPathMonitor = NWPathMonitor()
    private var interfaceType: NWInterface.InterfaceType? = nil     // 연결된 네트워크 방식

    // 네트워크 연결 상태 확인
    var isConnected: Bool { nwPathMonitor.currentPath.status == .satisfied }
    // 요금 사용 여부 확인
    var isExpensive: Bool { nwPathMonitor.currentPath.isExpensive }
        
    // 네트워크 상태 변동 실시간 확인
    func addObserver() {
        nwPathMonitor.pathUpdateHandler = { path in
            Task { @MainActor in
                self.pathUpdateHandleInsideTask(path)
            }
        }
        
        nwPathMonitor.start(queue: .main)
    }
    
    func removeObserverNetWork() {
        nwPathMonitor.cancel()
    }
    
    private func pathUpdateHandleInsideTask(_ path: NWPath) {
        // 이전과 동일한 네트워크 환경이라면 return
        guard self.interfaceType != path.availableInterfaces.first?.type else { return }
        
        if path.usesInterfaceType(.wifi) {
            print("Wi-Fi를 이용하여 네트워크에 연결되었습니다.")
        } else if path.usesInterfaceType(.cellular) {
            print("셀룰러 데이터를 이용하여 네트워크에 연결되었습니다.")
        } else if path.usesInterfaceType(.wiredEthernet) {
            print("유선 이더넷을 이용하여 네트워크에 연결되었습니다.")
        } else if path.usesInterfaceType(.loopback) {
            print("루프백을 이용하여 네트워크에 연결되었습니다.")
        } else if path.usesInterfaceType(.other) {
            print("기타 방법을 이용하여 네트워크에 연결되었습니다.")
        } else {
            print("네트워크에 연결할 수 없습니다.")
        }
        
        guard let interfaceType = nwPathMonitor.currentPath.availableInterfaces.first?.type else {
            self.interfaceType = nil
            return
        }
        
        self.interfaceType = interfaceType
    }
}
