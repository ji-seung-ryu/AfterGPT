//
//  ActivityIndicator.swift
//  Scrumdinger
//
//  Created by Ji-Seung on 1/25/24.
//

import SwiftUI

struct ActivityIndicator: View {
    @State private var isAnimating: Bool = true
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            .scaleEffect(1.5, anchor: .center)
            .onAppear() {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
            .onDisappear() {
                isAnimating = false
            }
    }
}
