(근데 이제 오디오에만 집중한...)

> [!question]
>  GQ1. AVFoundation은 어떤 일을 할까?
> GQ2. AVAudioPlayer는 어떻게 사용될까?
## **Description**
### **Definition**
**AVFoundation이란?**
- 오디오/비디오 재생, 녹음, 편집, 인코딩, 실시간 스트리밍 등 다양한 멀티미디어 기능을 제공한다.
**AVAudioPlayer란?**
- AVFoundation 프레임워크 내에서 **오디오 파일을 재생**할 수 있게 해주는 클래스이다.
- 로컬에 저장된 mp3, wav 등의 파일을 쉽게 재생하고, 일시정지, 반복 등의 기능을 제공한다.
- prepareToPlay(), stop()이나 play() 등의 메서드를 통해 오디오 재생을 제어할 수 있다.
### **Syntax**

```swift
import AVFoundation

class AudioManager: ObservableObject {
    var player: AVAudioPlayer?

    func playSound(named name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                player?.play()
            } catch {
                print("오디오 재생 실패: \(error.localizedDescription)")
            }
        }
    }
}
```

- AVAudioPlayer는 URL을 통해 오디오 파일을 로드함
- .play()로 재생 시작, .pause(), .stop() 등의 메서드로 제어 가능

## **주요 기능**
**오디오 재생 기능**
- mp3, wav 등 다양한 포맷의 로컬 오디오 파일 재생 가능
- 반복 재생 (numberOfLoops), 볼륨 설정 (volume), 현재 재생 위치 추적 (currentTime) 등 제어 가능
**다양한 미디어 처리 통합**
- AVFoundation은 단순 오디오뿐 아니라, **영상 촬영, 카메라 제어, 실시간 분석 (예: Vision, OCR)** 등과도 함께 쓰일 수 있음
## **코드 예시**
**AVAudioPlayer를 이용한 오디오 재생 예시**
``` swift
import Foundation
import AVFoundation
import SwiftUI

class JoidAudioPlayerViewModel: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
	
	func playSong() {
		guard let url = Bundle.main.url(forResource: "SampleSong", withExtension: "mp3") else {
            print("❌ 파일을 찾을 수 없습니다.")
            return
        }

        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()

        } catch{
            print("❌ 오디오 재생 중 오류: \(error.localizedDescription)")
        }
    }

    func stopSong() {
        audioPlayer?.stop()
    }

    func replaySong() {
        audioPlayer?.play()
    }

    func hasPlaybackProgress() -> Bool {
        return audioPlayer?.currentTime ?? 0 > 0
    }

    func resetSong() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
}

  

struct JoidMusicPlayView: View {
    @StateObject private var viewModel = JoidAudioPlayerViewModel()

    var body: some View {
        VStack(spacing: 30) {
            Text("내 여자 내 남자 - 배금성")
                .font(.title2)
            HStack{
                Button(action: {
                    if viewModel.hasPlaybackProgress() {
                        viewModel.replaySong()
                    } else{
                        viewModel.playSong()
                    }
                }) {
                    Text("노래 재생")
                        .font(.headline)
                        .padding()
                        .cornerRadius(12)
                }
                Button(action: {
                    viewModel.stopSong()
                }) {
                    Text("노래 정지")
                        .font(.headline)
                        .padding()
                        .cornerRadius(12)
                }
                Button(action: {
                    viewModel.resetSong()
                }) {
                    Text("처음부터")
                        .font(.headline)
                        .padding()
                        .cornerRadius(12)
                }
            }
        }
        .padding()
    }
}
```

## **Keywords**
- [[AVFoundation]]
- [[AVAudioPlayer]]
## **References**

- [AVFoundation 공식 문서](https://developer.apple.com/documentation/avfoundation)
- [AVAudioPlayer 공식 문서](https://developer.apple.com/documentation/avfaudio/avaudioplayer)
- ChatGPT