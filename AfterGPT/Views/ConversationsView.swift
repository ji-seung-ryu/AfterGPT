/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import GoogleMobileAds

struct ConversationsView: View {
    @Binding var sentences: [StoredSentence]
    @Binding var conversations: [Conversation]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewConversationView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($conversations) { $conversation in
                        NavigationLink(destination: ConversationDetailView(conversation: $conversation, sentences: $sentences)) {
                            ConversationCardView(conversation: conversation)
                        }
                        .listRowBackground(conversation.theme.mainColor)
                    }
                    .onDelete(perform: deleteConversations) // onDelete modifier added here
                }
                .navigationTitle("대화 기록")
                
                AdBannerView(adUnitID: "Replace with your ad unit ID") //
                                .frame(height: 50)

            }
            .toolbar {
                Button(action: {
                    isPresentingNewConversationView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Conversation")
            }
        }
        .sheet(isPresented: $isPresentingNewConversationView) {
            NewConversationSheet(conversations: $conversations, isPresentingNewConversationView: $isPresentingNewConversationView)
        }
       
    }
    
    private func deleteConversations(at offsets: IndexSet) {
        conversations.remove(atOffsets: offsets)
    }
}

struct AdBannerView: UIViewRepresentable {
    let adUnitID: String

    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: 320, height: 50))) // Set your desired banner ad size
        bannerView.adUnitID = adUnitID
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            bannerView.rootViewController = window.rootViewController
        }
        bannerView.load(GADRequest())
        return bannerView
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}


struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView(sentences: .constant(StoredSentence.sampleData), conversations: .constant(Conversation.sampleData))
    }
}
