import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @Binding var conversations : [Conversation]
    @Binding var sentences: [StoredSentence]
    @State private var errorWrapper: ErrorWrapper?
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: ()->Void
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ConversationsView(sentences: $sentences, conversations: $conversations)
            
                .sheet(item: $errorWrapper){
                    conversations = Conversation.sampleData
                } content:{ wrapper in
                    ErrorView(errorWrapper: wrapper)
                    
                }
                .tabItem {
                    Image(systemName: "message")
                    Text("대화기록")
                }
                .tag(0)
            
            StoredSentenceView(sentences: $sentences, conversations: $conversations)
                .sheet(item: $errorWrapper){
                    sentences = StoredSentence.sampleData
                } content:{ wrapper in
                    ErrorView(errorWrapper: wrapper)
                    
                }
                .tabItem {
                    Image(systemName: "memorychip")
                    Text("저장된 문장")
                }
                .tag(1)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                print("phase inactive")
                saveAction()
            }
            if phase == .background {
                print("phase background")
                saveAction()
            }
        }
        // .onchange 여기에다가 하는 게 맞겠다.
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(conversations: .constant(Conversation.sampleData), sentences: .constant(StoredSentence.sampleData) , saveAction: {})
        
    }
}
