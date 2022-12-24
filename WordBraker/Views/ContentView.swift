//
//  ContentView.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var wordStore: WordStore
    @State private var searchText = ""
    @State private var showInsertView = false
    
    @State private var showWalkthrough = true
    @AppStorage("hasViewedWalkthrough") var hasViewedWalkthrough = false
    
    enum FilterType: String, CaseIterable, Identifiable {
        case timeline, alphabetical
        var id: Self {
            self
        }
    }
    
    @State private var filterType: FilterType = .timeline
    
    var searchResults: [Word] {
        if searchText.isEmpty {
            if filterType == .alphabetical {
                return wordStore.words.sorted()
            } else {
                return wordStore.words
            }
        } else {
            if filterType == .alphabetical {
                return wordStore.words.filter { $0.question.localizedCaseInsensitiveContains(searchText) }.sorted()
            } else {
                return wordStore.words.filter { $0.question.localizedCaseInsensitiveContains(searchText) }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Picker("Filter Option", selection: $filterType) {
                ForEach(FilterType.allCases) { type in
                    Text("\(type.rawValue.capitalized)")
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            List {
                ForEach(searchResults) { word in
                    VStack(alignment: .leading) {
                        NavigationLink {
                            DetailView(word: word)
                        } label: {
                            HStack(spacing: 0) {
                                ForEach(1..<4, id: \.self) { index in
                                    if (word.rating - index + 1) > 0 {
                                        Image(systemName: "star.fill")
                                            .font(.headline)
                                            .foregroundColor(.red)
                                    } else {
                                        Image(systemName: "star")
                                            .font(.headline)
                                            .foregroundColor(.red)
                                    }
                                }
                                Spacer().frame(width: 10)
                                VStack(alignment: .leading) {
                                    Text(word.question)
                                        .font(.headline)
                                    Text(word.insertDate, style: .date)
                                        .foregroundColor(.secondary)
                                        .font(.caption)
                                }
                                Spacer()
                                Image(systemName: word.favorite ? "heart.fill" : "heart")
                                    .foregroundColor(word.favorite ? .orange : .secondary)
                                Spacer().frame(width: 10)
                                Image(systemName: word.isMemorized ? "checkmark.circle.fill" : "xmark.circle")
                                    .foregroundColor(word.isMemorized ? .primary : .secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: removeRows)
            }
            .navigationTitle("Word Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showInsertView.toggle()
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Looking for something")
            .fullScreenCover(isPresented: $showInsertView) {
                AddView()
            }
            .onAppear {
                showWalkthrough = hasViewedWalkthrough ? false : true
            }
            .sheet(isPresented: $showWalkthrough) {
                TutorialView()
            }
        }
        .task {
            prepareNotification()
        }
    }
    
    func prepareNotification() {
        guard wordStore.words.count > 0 else { return }
        let randomNumber = Int.random(in: 0..<wordStore.words.count)
        let suggestedWord = wordStore.words[randomNumber]
        Notification.notificationRequest(suggestedWord)
    }
    
    func removeRows(at indexSet: IndexSet) {
        for index in indexSet {
            if let firstIndex = wordStore.words.firstIndex(where: { $0.id == searchResults[index].id }) {
                wordStore.words.remove(at: firstIndex)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WordStore())
    }
}
