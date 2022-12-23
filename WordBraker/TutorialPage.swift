//
//  TutorialPage.swift
//  FoodPin
//
//  Created by 하진호 on 2022/12/05.
//

import SwiftUI

struct TutorialPage: View {
    let image: String
    let heading: String
    let subHeading: String
    
    var body: some View {
        VStack(spacing: 70) {
            Image(image)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.gray, lineWidth: 2)
                }
                .shadow(radius: 5)
            
            VStack(spacing: 10) {
                Text(heading)
                    .font(.headline)
                
                Text(subHeading)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            Spacer()
        }
        .padding(.top)
    }
}


struct TutorialPage_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage(image: "onboarding-1", heading: "CREATE YOUR FOOD GUIDE", subHeading: "Pin your favorate restaurants and create your own food guide")
    }
}
