//
//  WordBrakerApp.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/20.
//

import SwiftUI

@main
struct WordBrakerApp: App {
    @StateObject private var wordStore = WordStore()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(wordStore)
                .onAppear {
                    Notification.notificationAuthorization()
                }
        }
    }
}
