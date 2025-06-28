//
//  ContentView.swift
//  Gacha
//
//  Created by 杉井位次 on 2025/06/28.
//

import SwiftUI

struct ContentView: View {
    
    @State var showSheet = false
    
    var body: some View {
        ZStack {
            Image("gacha")
                .resizable()
                .ignoresSafeArea()
            Button {
                showSheet = true
            } label: {
                Image("Presentbox")
                    .resizable()
                    .scaledToFit()//アスペクト比保つ
            }
        }
        .fullScreenCover(isPresented: $showSheet) { //フルスクリーン表示のモーダル画面を表示showSheetが正の時発火
            ResultView()
        }
    }
}

#Preview {
    ContentView()
}
