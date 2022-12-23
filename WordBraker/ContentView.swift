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
        case alphbet, time
        var id: Self {
            self
        }
    }
    
    @State private var filterType: FilterType = .alphbet
    
    var searchResults: [Word] {
        if searchText.isEmpty {
            if filterType == .alphbet {
                return wordStore.words.sorted()
            } else {
                return wordStore.words
            }
            
        } else {
            if filterType == .alphbet {
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
                    Text("\(type.rawValue)")
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
                            VStack(alignment: .leading) {
                                Text(word.question)
                                    .font(.headline)
                                Text(word.insertDate, style: .date)
                                    .foregroundColor(.secondary)
                                    .font(.caption)
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
            .sheet(isPresented: $showInsertView) {
                AddView()
            }
            .onAppear {
                showWalkthrough = hasViewedWalkthrough ? false : true
            }
            .sheet(isPresented: $showWalkthrough) {
                TutorialView()
            }
        }
    }
    
    func removeRows(at indexSet: IndexSet) {
        wordStore.words.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WordStore())
    }
}
