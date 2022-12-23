//
//  MainView.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/23.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tabItem {
                    Label("Wordlists", systemImage: "house.fill")
                }
                .tag(0)
            
            TutorialView()
                .tabItem {
                    Label("Tutorials", systemImage: "graduationcap.fill")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.2.fill")
                }
                .tag(2)
            
            AboutView()
                .tabItem {
                    Label("Abouts", systemImage: "square.stack")
                }
                .tag(3)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(WordStore())
    }
}
