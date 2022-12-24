//
//  TestView.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/24.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var wordStore: WordStore
    
    var body: some View {
        Text("Select new test method?")
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(WordStore())
    }
}
