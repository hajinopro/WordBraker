//
//  DetailView.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/21.
//

import AVFoundation
import SwiftUI

struct DetailView: View {
    @EnvironmentObject var wordStore: WordStore
    let word: Word
    let synthesizer = AVSpeechSynthesizer()
    @AppStorage("pronunciate") var pronunciate: String = "en-GB"
    
    var body: some View {
        Form {
            Section("Level") {
                HStack {
                    Text("Oxford Label")
                        .font(.headline)
                        .foregroundColor(.red)
                    Spacer()
                    ForEach(1..<4, id: \.self) { index in
                        if (word.rating - index + 1) > 0 {
                            Image(systemName: "star.fill")
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding(.leading, 10)
                                .onTapGesture {
                                    if let firstIndex = wordStore.words.firstIndex(of: word) {
                                        wordStore.words[firstIndex].rating = index
                                    }
                                }
                        } else {
                            Image(systemName: "star")
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding(.leading, 10)
                                .onTapGesture {
                                    if let firstIndex = wordStore.words.firstIndex(of: word) {
                                        wordStore.words[firstIndex].rating = index
                                    }
                                }
                        }
                    }
                }
                
                HStack {
                    Text("is Favorite")
                        .font(.headline)
                        .foregroundColor(.orange)
                    Spacer()
                    Image(systemName: word.favorite ? "heart.fill" : "heart")
                        .font(.headline)
                        .foregroundColor(word.favorite ? .orange : .secondary)
                        .onTapGesture {
                            if let firstIndex = wordStore.words.firstIndex(of: word) {
                                wordStore.words[firstIndex].favorite.toggle()
                            }
                        }
                }
                
                HStack {
                    Text("is Memorized")
                        .font(.headline)
                    Spacer()
                    Image(systemName: word.isMemorized ? "checkmark.circle.fill" : "xmark.circle")
                        .font(.headline)
                        .foregroundColor(word.isMemorized ? .primary : .secondary)
                        .onTapGesture {
                            if let firstIndex = wordStore.words.firstIndex(of: word) {
                                wordStore.words[firstIndex].isMemorized.toggle()
                            }
                        }
                }
            }
            
            Section("pronunciation & meaning") {
                Label(word.answer, systemImage: "mic.fill")
                    .font(.headline)
                    .onTapGesture {
                        let utterance = AVSpeechUtterance(string: word.question)
                        utterance.voice = AVSpeechSynthesisVoice(language: pronunciate)
                        synthesizer.speak(utterance)
                    }
            }
            
            Section("Example") {
                Label(word.sentence, systemImage: "mic.fill")
                    .font(.headline)
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
                .environmentObject(WordStore())
        }
    }
}
