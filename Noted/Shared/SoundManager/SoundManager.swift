//
//  SoundManager.swift
//  Noted
//
//  Created by Ikmal Azman on 21/06/2021.
//

import Foundation
import AVFoundation

final class SoundManager {

    static let shared = SoundManager()

    private var player: AVAudioPlayer?

    func playSound(soundFileName: String) {

        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: ".wav") else {return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

            guard let player = player else {return}
            player.play()
        } catch {
            print("Error play sound from music file : \(error.localizedDescription)")
        }
    }
}
