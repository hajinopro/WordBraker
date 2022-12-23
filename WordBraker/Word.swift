//
//  Word.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/20.
//

import SwiftUI

struct Word: Identifiable, Codable, Comparable {
    static func < (lhs: Word, rhs: Word) -> Bool {
        lhs.question < rhs.question
    }
    
    var id = UUID()
    var question: String
    var answer: String
    var sentence: String
    var insertDate = Date.now
    
    static let example = Word(question: "decieve", answer: "to make (someone) believe something that is not true", sentence: "Her husband had been deceiving her for years.")
}

class WordStore: ObservableObject {
    @Published var words: [Word]
    private let saveUrl = URL.documentsDirectory.appending(path: "WordBook")
    
    init() {
        words = WordStore.examples
    }
    
    func add(_ word: Word) {
        words.append(word)
        save()
    }
    
    func update() {
        
    }
    
    func load() {
        if let data = try? Data(contentsOf: saveUrl) {
            if let decodedData = try? JSONDecoder().decode([Word].self, from: data) {
                words = decodedData
            }
        } else {
            words = []
        }
    }
    
    func save() {
        do {
            let encodedData = try JSONEncoder().encode(words)
            try encodedData.write(to: saveUrl, options: [.atomic, .completeFileProtection])
        } catch {
            print("Failed to save your word data.")
        }
    }
    
    static let examples = [
        Word(question: "decieve", answer: "to make (someone) believe something that is not true", sentence: "Her husband had been deceiving her for years.", insertDate: Date.now.addingTimeInterval(-86400 * 2)),
        Word(question: "abide", answer: "to accept or bear (someone or something bad, unpleasant, etc.)", sentence: "I can’t abide people with no sense of humour.", insertDate: Date.now.addingTimeInterval(-86400)),
        Word(question: "abide by something", answer: "to accept a rule, a law, an agreement, a decision, etc. and obey it", sentence: "He will abide by poll telling him to resign as CEO.")
    ]
}
