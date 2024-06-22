//
//  ConversationCardView.swift
//  Scrumdinger
//
//  Created by Ji-Seung on 1/15/24.
//


import SwiftUI

struct StoredSentenceCardView: View{
    let sentence: StoredSentence
    var body: some View{
        VStack(alignment: .leading) {
            Text(sentence.title!)
                .font(.headline)
            
            .font(.caption)
        }
        .padding()
        .foregroundColor(sentence.theme.accentColor)
        
    }
}



struct StoredSentenceCardView_Previews: PreviewProvider {
    static var sentence = StoredSentence.sampleData[0]
    
    static var previews: some View {
        return StoredSentenceCardView(sentence: sentence)
            .background(sentence.theme.mainColor)
            .previewLayout(.fixed(width: 300, height: 70))  // 프리뷰의 크기를 지정할 수 있습니다.
    }
}
