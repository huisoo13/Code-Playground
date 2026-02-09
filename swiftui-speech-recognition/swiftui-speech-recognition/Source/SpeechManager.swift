//
//  SpeechManager.swift
//  swiftui-speech-recognition
//
//  Created by Huisoo on 2/10/26.
//

import Foundation
import Speech
import AVFoundation

@Observable
class SpeechManager {
    enum SpeechError: Error {
        case audioInputMuted
        case serviceNotAvailable
        case speechRecognizerDenied
        case microphoneAccessDenied
        
        var localizedDescription: String {
            switch self {
            case .audioInputMuted:
                return "오디오 입력 음소거 상태"
            case .serviceNotAvailable:
                return "음성 인식 서비스 사용 불가"
            case .speechRecognizerDenied:
                return "음성 인식 권한 거부"
            case .microphoneAccessDenied:
                return "마이크 접근 권한 거부"
            }
        }
    }
    
    private var audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    
    private var sessionCategory: AVAudioSession.Category = .playback
    private var sessionMode: AVAudioSession.Mode = .default
    private var sessionOptions: AVAudioSession.CategoryOptions = []

    var transcript: String = ""
    var isRecording: Bool = false
    
    // MARK: Public
    
    func prepareTranscribing() async throws {
        // 오디오 음소거 상태 확인
        guard !AVAudioApplication.shared.isInputMuted else {
            throw SpeechError.audioInputMuted
        }
        
        // 시스템적 사용 여부 확인 (다른 앱이 마이크 또는 음성 인식 소스를 독점적으로 사용 중 인 경우)
        guard let isAvailable = speechRecognizer?.isAvailable, isAvailable else {
            throw SpeechError.serviceNotAvailable
        }
        
        // 음성 인식 권한 확인
        let isSpeechRecoginzable = await checkSpeechRecognizerPermission()
        guard isSpeechRecoginzable else {
            throw SpeechError.speechRecognizerDenied
        }
        
        // 마이크 사용 권한 확인
        let isMicrophoneAccessible = await checkMicrophonePermission()
        guard isMicrophoneAccessible else {
            throw SpeechError.microphoneAccessDenied
        }
    }

    func startTranscribing() {
        // 기존 작업 초기화
        stopTranscribing()
        
        do {
            let audioSession = AVAudioSession.sharedInstance()

            // 오디오 세션 기본값 저장
            sessionCategory = audioSession.category
            sessionMode = audioSession.mode
            sessionOptions = audioSession.categoryOptions
            
            // 오디오 세션 설정
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true)
            
            // 리퀘스트 생성
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else { return }
            recognitionRequest.shouldReportPartialResults = true // 중간 결과 보고 활성화
            
            // 마이크 입력 연결
            let inputNode = audioEngine.inputNode
            let inputFormat = inputNode.inputFormat(forBus: 0)

            // 포맷 유효성 체크
            guard inputFormat.sampleRate > 0, inputFormat.channelCount > 0 else { return }

            let outputFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: outputFormat) { buffer, _ in
                recognitionRequest.append(buffer)
            }
            
            // 엔진 시작
            audioEngine.prepare()
            try audioEngine.start()
            
            // 음성 인식 태스크 시작
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                guard let result, (!result.isFinal && error.isNil) else {
                    self.stopTranscribing()
                    return
                }
                
                // 실시간 텍스트 업데이트
                self.transcript = result.bestTranscription.formattedString
            }
            
            isRecording = true
        } catch {
            stopTranscribing()
        }
    }
    
    func stopTranscribing() {
        defer { isRecording = false }

        guard !recognitionRequest.isNil, !recognitionTask.isNil else { return }
        
        // 종료
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        
        // 초기화
        recognitionRequest = nil
        recognitionTask = nil
        
        do {
            // 오디오 세션 설정
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(sessionCategory, mode: sessionMode, options: sessionOptions)
            try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session unactivation failed. \(error)")
        }
    }
        
    // MARK: Private
    
    private func checkSpeechRecognizerPermission() async -> Bool {
        return await withCheckedContinuation { continuation in
            switch SFSpeechRecognizer.authorizationStatus() {
            case .notDetermined:
                // 권한이 요청하기 전
                SFSpeechRecognizer.requestAuthorization { status in
                    DispatchQueue.main.async {
                        switch status {
                        case .authorized:
                            // 권한을 허용
                            continuation.resume(returning: true)
                        case .denied:
                            // 권한을 거부
                            continuation.resume(returning: false)
                        default:
                            // 그 외
                            continuation.resume(returning: false)
                        }
                    }
                }
            case .authorized:
                // 권한이 있는 경우
                continuation.resume(returning: true)
            default:
                // 권한이 없는 경우
                continuation.resume(returning: false)
            }
        }
    }
    
    private func checkMicrophonePermission() async -> Bool {
        return await withCheckedContinuation { continuation in
            switch AVAudioApplication.shared.recordPermission {
            case .undetermined:
                // 권한 요청 전
                AVAudioApplication.requestRecordPermission { granted in
                    continuation.resume(returning: granted)
                }
            case .granted:
                // 권한이 있는 경우
                continuation.resume(returning: true)
            default:
                // 권한이 없는 경우
                continuation.resume(returning: false)
            }
        }
    }
}

fileprivate extension Optional {
    var isNil: Bool {
        return self == nil
    }
}
