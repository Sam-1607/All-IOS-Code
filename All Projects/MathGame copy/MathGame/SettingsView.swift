//
//  SettingsView.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/27/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State var musicLabelSystemImage = "speaker.wave.3.fill"
    @State var soundEffectsLabelSystemImage = "speaker.wave.3.fill"
    @State var musicState = true
    @State var soundEffectState = true
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
               VStack {
                   HStack(spacing: 100) {
                VStack {
                    Text("Music")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .font(.system(size: 30))
                        .underline()
                    
                    Button {
                        self.musicState.toggle()
                        changeLabels()
                    } label: {
                        Image(systemName: "\(musicLabelSystemImage)")
                    }
                   
                    .foregroundColor(.yellow)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                }
                    VStack {
                        Text("Effects")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .font(.system(size: 30))
                            .underline()
                        
                        Button {
                            self.soundEffectState.toggle()
                            changeLabels()
                        } label: {
                            Image(systemName: "\(soundEffectsLabelSystemImage)")
                        }
                        .foregroundColor(.yellow)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        
                    }
                }
                   Spacer()
               }
            }
        }
    }
    func changeLabels() {
        if self.musicState == true {
            self.musicLabelSystemImage = "speaker.wave.3.fill"
            audioPlayer.player?.play()
        } else {
            self.musicLabelSystemImage = "speaker.slash.fill"
            audioPlayer.player?.pause()
        }
        
        if self.soundEffectState == true {
            self.soundEffectsLabelSystemImage = "speaker.wave.3.fill"
            audioPlayer.incorrectPlayer?.play()
            audioPlayer.correctPlayer?.play()
        } else {
            self.soundEffectsLabelSystemImage = "speaker.slash.fill"
            audioPlayer.correctPlayer?.pause()
            audioPlayer.correctPlayer?.pause()
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
