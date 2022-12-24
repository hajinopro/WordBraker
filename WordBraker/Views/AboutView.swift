//
//  AboutView.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/23.
//

import SwiftUI

struct AboutView: View {
    enum WebLink: String, Identifiable {
        var id: UUID {
            UUID()
        }
        
        case rateUs = "https://www.apple.com/ios/app-store"
        case feedback = "https://www.apple.kr"
        case twitter = "https://www.twitter.com/gkwlsgh"
        case facebook = "https://www.facebook.com/hajinopro"
        case instagram = "https://www.instagram.com/hajinopro"
    }

    @State private var safari: WebLink?
    @State private var showTutorial = false
    
    var body: some View {
        NavigationStack {
            List {
                Image("about")
                    .resizable()
                    .scaledToFill()
                
                Section {
                    Label(String(localized: "Rate us on App Store", comment: "Rate us on App Store"), systemImage: "house.circle.fill")
                        .foregroundColor(.primary)
                        .onTapGesture {
                            safari = .rateUs
                        }
                    
                    
                    Label(String(localized: "Tell us your feedback", comment: "Tell us your feedback"), systemImage: "character.bubble.fill")
                        .foregroundColor(.primary)
                        .onTapGesture {
                            safari = .feedback
                        }
                    
                    Button {
                        showTutorial.toggle()
                    } label: {
                        Label("Tutorial View", systemImage: "graduationcap.circle.fill")
                            .foregroundColor(.primary)
                    }
                }
                .sheet(isPresented: $showTutorial) {
                    TutorialView()
                }
                
                Section {
                    Label(String(localized: "Twitter", comment: "Twitter"), systemImage: "bird.fill")
                        .foregroundColor(.cyan)
                        .onTapGesture {
                            safari = .twitter
                        }
                    Label(String(localized: "Facebook", comment: "Facebook"), systemImage: "f.square.fill")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            safari = .facebook
                        }
                    Label(String(localized: "Instagram", comment: "Instagram"), systemImage: "i.square.fill")
                        .foregroundColor(.red)
                        .onTapGesture {
                            safari = .instagram
                        }
                }
            }
            .sheet(item: $safari) { item in
                if let url = URL(string: item.rawValue) {
                    SafariView(url: url)
                }
            }
            .listStyle(.grouped)
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
