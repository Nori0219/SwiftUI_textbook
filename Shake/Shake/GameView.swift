//
//  GameView.swift
//  Shake
//
//  Created by 杉井位次 on 2025/06/29.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    
    @StateObject private var shakeDetector = ShakeDetector()
    @State private var bubbleAudioPlayer: AVAudioPlayer!
    @State private var boomAudioPlayer: AVAudioPlayer!
    
    @State var limit = Int.random(in: 90...150) //ゲームオーバーの回数を乱数で決める
    @State var yScale: CGFloat = 1
    @State var xScale: CGFloat = 1
    @State var isGameOver = false
    
    var body: some View {
        Group {
            if !isGameOver {
                Image("bottle")
                    .resizable()
                    .frame(width: 150, height: 450)
                    .scaleEffect(x: xScale, y: yScale)
            } else {
                VStack(spacing: 40) {
                    Image("gameover")
                        .resizable()
                        .scaledToFit()
                    Text("Game Over!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                    Button("もう一度") {
                        restartGame()
                    }
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 250, height: 70)
                    .background(Color.blue)
                    .clipShape(.rect(cornerRadius: 20))
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationBarBackButtonHidden()//戻るボタンを非表示
        .onAppear { // 画面に表示されたときに音楽ファイルをロードしておく
            bubbleAudioPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "bubble")!.data)
            bubbleAudioPlayer.prepareToPlay()
            boomAudioPlayer = try! AVAudioPlayer(data: NSDataAsset(name: "boom")!.data)
            boomAudioPlayer.prepareToPlay()
        }
        .onChange(of: shakeDetector.shakeCount) {
            if shakeDetector.shakeCount < limit && !isGameOver {
                playSoundAndHaptic()
                print("シェイクが検出されました！回数: \(shakeDetector.shakeCount)")
                
                let scale = CGFloat(shakeDetector.shakeCount) / CGFloat(limit)
                xScale = 1 + scale * 1.5
                yScale = 1 + scale
            } else {
                gameover()
            }
        }
    }
    
    
    func playSoundAndHaptic() {
        bubbleAudioPlayer.currentTime = 0
        bubbleAudioPlayer.play()
        let generator = UIImpactFeedbackGenerator(style: .rigid) //バイブ機能
        generator.impactOccurred()
    }
    
    func gameover() {
        isGameOver = true
        boomAudioPlayer.currentTime = 0
        boomAudioPlayer.play()

        //振動を繰り返す
        for i in 0..<6 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        }
    }
    
    func restartGame() { //初期化
        isGameOver = false
        shakeDetector.shakeCount = 0
        limit = Int.random(in: 90...150)
        xScale = 1
        yScale = 1
    }
    
    
}

#Preview {
    GameView()
}
