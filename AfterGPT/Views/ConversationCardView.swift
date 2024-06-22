//
//  ConversationCardView.swift
//  Scrumdinger
//
//  Created by Ji-Seung on 1/15/24.
//


import SwiftUI

struct ConversationCardView: View{
    let conversation: Conversation
    var body: some View{
        VStack(alignment: .leading) {
            Text(conversation.title)
                .font(.headline)
            Spacer()
            HStack {
                HStack {
                    Image(systemName: "message.fill")
                    Text("\(conversation.evaluatedMessages.count) sentences")
                }
                Spacer()
                HStack {
                    Image(systemName: "calendar")
                    Text("\(conversation.formattedDate)")
                }
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(conversation.theme.accentColor)
        
    }
}



struct ConversationCardView_Previews: PreviewProvider {
    static var conversation = Conversation.sampleData[0]
    
    static var previews: some View {
        return ConversationCardView(conversation: conversation)
            .background(conversation.theme.mainColor)
            .previewLayout(.fixed(width: 300, height: 70))  // 프리뷰의 크기를 지정할 수 있습니다.
    }
}
