//
//  SettingsView.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/27/22.
//

import SwiftUI
import AVKit

struct SettingsView: View {
    
    @State var musicLabelSystemImage: String?
    @State var soundEffectsLabelSystemImage: String?
    @State var musicState: Bool?
    @State var soundEffectState: Bool?
    
    
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
                        guard musicState != nil else {
                            return
                        }
                        self.musicState!.toggle()
                        changeLabels()
                    } label: {
                        Image(systemName: "\(musicLabelSystemImage ?? "speaker.wave.3.fill")")
                    }
                   
                    .foregroundColor(.yellow)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .onLoad {
                        self.musicState = true
                        self.musicLabelSystemImage = "speaker.wave.3.fill"
                    }
                }
                    VStack {
                        Text("Effects")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .font(.system(size: 30))
                            .underline()
                        
                        Button {
                            if soundEffectState != nil {
                                self.soundEffectState!.toggle()
                                changeLabels()
                            }
                            
                        } label: {
                            Image(systemName: "\(soundEffectsLabelSystemImage ?? "speaker.wave.3.fill")")
                        }
                        .foregroundColor(.yellow)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .onLoad {
                            self.soundEffectState = true
                            self.soundEffectsLabelSystemImage = "speaker.wave.3.fill"
                        }
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
            audioPlayer.incorrectPlayer = AVAudioPlayer()
            audioPlayer.correctPlayer = AVAudioPlayer()
        } else {
            self.soundEffectsLabelSystemImage = "speaker.slash.fill"
            audioPlayer.incorrectPlayer = nil
            audioPlayer.correctPlayer = nil
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
