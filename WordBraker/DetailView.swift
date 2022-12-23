//
//  DetailView.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/21.
//

import AVFoundation
import SwiftUI

struct DetailView: View {
    let word: Word
    let synthesizer = AVSpeechSynthesizer()
    @AppStorage("pronunciate") var pronunciate: String = "en-GB"
    
    var body: some View {
        Form {
            Section("pronunciation & meaning") {
                Label(word.answer, systemImage: "mic.fill")
                    .font(.headline)
                    .onTapGesture {
                        let utterance = AVSpeechUtterance(string: word.question)
                        utterance.voice = AVSpeechSynthesisVoice(language: pronunciate)
                        synthesizer.speak(utterance)
                    }
            }
            
            Section("sentence") {
                Text(word.sentence)
                    .font(.callout)
                    .foregroundColor(.indigo)
                    .onTapGesture {
                        let utterance = AVSpeechUtterance(string: word.sentence)
                        utterance.voice = AVSpeechSynthesisVoice(language: pronunciate)
                        synthesizer.speak(utterance)
                    }
            }
        }
        .navigationTitle(word.question)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(word: Word.example)
        }
    }
}
