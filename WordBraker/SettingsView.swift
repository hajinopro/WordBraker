//
//  SettingsView.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("pronunciate") var pronunciate: String = "en-GB"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Favorite Pronunciation") {
                    Picker("Favorite pronunciation", selection: $pronunciate) {
                        ForEach(Settings.allCases) { item in
                            Text("\(item.rawValue)")
                                .tag(item.pronunciate)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
