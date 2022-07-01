//
//  SettingsView.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/27/22.
//

import SwiftUI
import AVKit

var musicState = true
var soundEffectState = true
var soundPlayer = SoundController()

struct SettingsView: View {
    
    @State var musicLabelSystemImage = "speaker.wave.3.fill"
    @State var soundEffectsLabelSystemImage = "speaker.wave.3.fill"
    @State var player: AVAudioPlayer?

    
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
                        soundPlayer.playSoundEffect(soundName: "sound", soundType: "mp3", somePlayer: &self.player)

                        musicState.toggle()
                        changeLabels()
                    } label: {
                        Image(systemName: "\(musicLabelSystemImage)")
                    }
                    .foregroundColor(.yellow)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .onAppear {
                        changeLabels()
                    }
                }
                    VStack {
                        Text("Effects")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .font(.system(size: 30))
                            .underline()
                        
                        Button {
                                soundEffectState.toggle()
                                changeLabels()
                            soundPlayer.playSoundEffect(soundName: "sound", soundType: "mp3", somePlayer: &self.player)

                        } label: {
                            Image(systemName: "\(soundEffectsLabelSystemImage)")
                        }
                        .foregroundColor(.yellow)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .onAppear {
                            changeLabels()
                        }
                    }
                }
                   Spacer()
               }
            }
        }
    }
    func changeLabels() {
        if musicState == true {
            self.musicLabelSystemImage = "speaker.wave.3.fill"
            globalPlayer?.play()
        } else {
            self.musicLabelSystemImage = "speaker.slash.fill"
            globalPlayer?.pause()
        }
        
        if soundEffectState == true {
            self.soundEffectsLabelSystemImage = "speaker.wave.3.fill"
        } else {
            self.soundEffectsLabelSystemImage = "speaker.slash.fill"
        }
            
    }
        
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
