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
    //var thumbnailImage: Image = Image(systemName: "mug.fill")
    var question: String
    var answer: String
    var sentence: String
    var insertDate = Date.now
    var isMemorized: Bool = false // Test를 통해서 외웠는지 여부
    var favorite: Bool = false // 당신이 좋아하는 단어, 정이가는 단어....
    var rating: Int = 3 // Oxford 3000에 속하는 중요 어휘(별3개), Oxford 5000에 속하는 어휘(별2개), Oxford 10,000에 속하는 어휘(별1개)
    
    static let example = Word(question: "decieve", answer: "to make (someone) believe something that is not true", sentence: "Her husband had been deceiving her for years.", rating: 2)
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
        Word(question: "decieve", answer: "to make (someone) believe something that is not true", sentence: "Her husband had been deceiving her for years.", insertDate: Date.now.addingTimeInterval(-86400 * 2),favorite: true, rating: 2),
        Word(question: "abide", answer: "to accept or bear (someone or something bad, unpleasant, etc.)", sentence: "I can’t abide people with no sense of humour.", insertDate: Date.now.addingTimeInterval(-86400), isMemorized: true),
        Word(question: "abide by something", answer: "to accept a rule, a law, an agreement, a decision, etc. and obey it", sentence: "He will abide by poll telling him to resign as CEO.", favorite: true, rating: 1)
    ]
}
