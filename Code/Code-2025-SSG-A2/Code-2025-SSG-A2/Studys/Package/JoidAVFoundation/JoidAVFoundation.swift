//
//  JoidAVFoundation.swift
//  Code-2025-SSG-A2
//
//  Created by 나현흠 on 6/22/25.
//

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

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
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
                    } else {
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

#Preview {
    JoidMusicPlayView()
}
