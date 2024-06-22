//
//  OnboardingArrayView.swift
//  Scrumdinger
//
//  Created by Ji-Seung on 2/7/24.
//

import SwiftUI

struct OnboardingArrayView: View {
    var onboardingArray: [Onboarding]
    
    @State private var currentIndex: Int = 0
    
    var body: some View{
        GeometryReader { geometry in
            
            ZStack {
                SwiftyUIScrollView(axis: .horizontal, numberOfPages: self.onboardingArray.count, pagingEnabled: true, pageControlEnabled: true, hideScrollIndicators: true, currentPageIndicator: .black, pageIndicatorTintColor: .gray) {
                    HStack(spacing: 0) {
                        ForEach(self.onboardingArray, id: \.id) { item in
                            OnboardingView(onboardingData: item)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }
            
        }
    }
}

struct OnboardingArrayView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingArrayView(onboardingArray: Onboarding.sampleData)
    }
}

