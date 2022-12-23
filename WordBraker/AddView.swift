//
//  InsertView.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/22.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var question = ""
    @State private var answer = ""
    @State private var sentence = ""
    @Environment(\.dismiss) var dismiss
    
    enum Field {
        case question, answer, sentence
    }
    
    @FocusState var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("New Word") {
                    TextField("Enter new word...", text: $question)
                        //.autocapitalization(.none)
                        .focused($focusedField, equals: .question)
                        .onSubmit {
                            focusedField = .answer
                        }
                }
                
                Section("Meaning") {
                    TextField("What dose it mean...", text: $answer)
                        .focused($focusedField, equals: .answer)
                        .onSubmit {
                            focusedField = .sentence
                        }
                }
                
                Section("Example") {
                    TextField("For example ...", text: $sentence)
                        .focused($focusedField, equals: .sentence)
                        .onSubmit {
                            focusedField = nil
                        }
                }
                
                Button {
                    let newWord = Word(question: question, answer: answer, sentence: sentence)
                    wordStore.add(newWord)
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(question.isEmpty && answer.isEmpty)
            }
            .navigationTitle("Add View")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(WordStore())
    }
}
