import SwiftUI

struct StoredSentenceView: View {
    @Binding var sentences: [StoredSentence]
    @Binding var conversations: [Conversation]
    @State private var isShuffled = false // State 변수 추가

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($sentences) { $sentence in
                        NavigationLink(destination: StoredSentenceDetailView(sentence: $sentence)) {
                            StoredSentenceCardView(sentence: sentence)
                        }
                        .listRowBackground(sentence.theme.mainColor)
                    }
                    .onDelete(perform: deleteConversations)
                }
                .navigationTitle("저장된 문장")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.sentences.shuffle()
                            self.isShuffled.toggle()
                        }) {
                            Text("랜덤으로 재배열")
                        }
                    }
                }
                
                AdBannerView(adUnitID: "Replace with your ad unit ID") // Replace with your ad unit ID
                                .frame(height: 50)
                
                
                
            }
        }
    }
    
    private func deleteConversations(at offsets: IndexSet) {
        for offset in offsets {
            let sentence = sentences[offset]
            // Find the conversation with the same conversation_id
            if let conversationIndex = conversations.firstIndex(where: { $0.id == sentence.conversation_id }) {
                // Find evaluated message with the same message_id and set isSaved to false
                if let evaluatedMessageIndex = conversations[conversationIndex].evaluatedMessages.firstIndex(where: { $0.id == sentence.message_id }) {
                    // Modify the isSaved property directly in the array
                    conversations[conversationIndex].evaluatedMessages[evaluatedMessageIndex].isSaved = false
                }
            }
        }
        sentences.remove(atOffsets: offsets)
    }

}

struct StoredSentenceView_Previews: PreviewProvider {
    static var previews: some View {
        StoredSentenceView(sentences: .constant(StoredSentence.sampleData), conversations: .constant(Conversation.sampleData))
    }
}
