//
//  TutorialView.swift
//  FoodPin
//
//  Created by 하진호 on 2022/12/05.
//

import SwiftUI

struct TutorialView: View {
    let pageHeadings = [
        "CREATE YOUR OWN WORD BOOK",
        "SHOW YOU THE DETAIL",
        "DISCOVER GREAT WORDS"
    ]
    
    let pageSubHeadings = [
        "Enter new english words and create your own word book",
        "Search and edit your word on list",
        "Explore new words shared by your friends and other people"
    ]
    
    let pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemIndigo
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
    }
    
    @State private var currentPage = 0
    @Environment(\.dismiss) var dismiss
    @AppStorage("hasViewedWalkthrough") var hasViewedWalkthrough = false
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(pageHeadings.indices, id: \.self) { index in
                    TutorialPage(image: pageImages[index], heading: pageHeadings[index], subHeading: pageSubHeadings[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .animation(.default, value: currentPage)
            
            VStack(spacing: 20) {
                Button {
                    if currentPage < pageHeadings.count - 1 {
                        currentPage += 1
                    } else {
                        hasViewedWalkthrough = true
                        dismiss()
                    }
                } label: {
                    Text(currentPage == pageHeadings.count - 1 ? "GET STARTED" : "NEXT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 50)
                        .background(Color(.systemIndigo))
                        .cornerRadius(25)
                }
                
                if currentPage < pageHeadings.count - 1 {
                    Button {
                        hasViewedWalkthrough = true
                        dismiss()
                    } label: {
                        Text("Skip")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}

