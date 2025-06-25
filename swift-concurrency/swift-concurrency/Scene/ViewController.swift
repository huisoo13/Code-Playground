//
//  ViewController.swift
//  swift-concurrency
//
//  Created by Huisoo on 6/20/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        task4()
    }

    func task1() {
        // 비동기 함수를 순차적으로 호출
        Task {
            let actor = Actor()
            await actor.increment()
            await actor.decrement()
        }
    }
    
    func task2() {
        // 동일한 비동기 함수를 여러번 직렬로 실행
        Task {
            let actor = Actor()

            let asyncStream: AsyncStream<Void> = AsyncStream { continuation in
                Task {
                    for _ in 1...5 {
                        await actor.printA()
                        continuation.yield()
                    }

                    continuation.finish()
                }
            }
            
            for await _ in asyncStream {
                // code..
            }
        }
    }
    
    func task3() {
        // 동일한 비동기 함수를 여러번 병렬로 실행
        Task {
            let actor = Actor()
            
            await withTaskGroup { group in
                for _ in 1...5 {
                    group.addTask {
                        await actor.decrement()
                    }
                }
            }
        }
    }

    func task4() {
        // 동일하지 않은 비동기 함수를 병렬로 실행
        Task {
            let actor = Actor()
            
            async let printA: () = actor.printA()
            async let printB: () = actor.printB()
            
            // 두 함수가 모두 완료될 때가지 대기
            let _ = await (printA, printB)
        }
    }
    
    func closureToAsync() async {
        return await withCheckedContinuation { continuation in
            let actor = Actor()
            
            actor.closure {
                continuation.resume()
            }
        }
    }
}

