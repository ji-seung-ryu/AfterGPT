//
//  ConversationDetailView.swift
//  SwiftUIStarterKitApp
//
//  Created by Ji-Seung on 1/10/24.
//  Copyright © 2024 NexThings. All rights reserved.
//

import SwiftUI

struct ConversationDetailView: View {
    @Binding var conversation: Conversation
    @Binding var sentences: [StoredSentence]
    @State private var editingConversation = Conversation.emptyConversation
    @State private var isPresentingEditView = false
    @State private var isLoading: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    
    var body: some View {
        List {
            Section(header: Text("대화 기록")) {
                ForEach(conversation.evaluatedMessages.indices) { index in
                    NavigationLink(destination:
                                    SentenceDetailView(evaluatedMessage: $conversation.evaluatedMessages[index], sentences: $sentences, conversation_id: conversation.id)) {
                        EvaluatedMessageRow(evaluatedMessage: conversation.evaluatedMessages[index]).padding(.vertical, 8)                  }
                }
            }
        }
        .navigationTitle(conversation.title)
        .toolbar{
            Button("Edit"){
                isPresentingEditView = true
                editingConversation = conversation
            }
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationStack{
                DetailEditView(conversation: $editingConversation)
                    .navigationTitle(conversation.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                conversation = editingConversation
                            }
                        }
                    }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        //색깔 신경쓰자
        //실제 db 에 추가해서 넣는것
        
    }
    
    
}



struct EvaluatedMessageRow: View {
    var evaluatedMessage: EvaluatedMessage
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if evaluatedMessage.message.sender == "user" {
                    Text("User")
                        .font(.caption)
                        .foregroundColor(Color.blue)
                } else {
                    Text("ChatGPT")
                        .font(.caption)
                        .foregroundColor(Color.green)
                }
                Spacer() // 공간을 채우기 위해 Spacer 추가
            }
            
            Text(evaluatedMessage.message.content)
            
        }
        
    }
}



struct ConversationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationDetailView(
            conversation: .constant(Conversation.sampleData[0])
            ,sentences: .constant(StoredSentence.sampleData
                                 )
        )
    }
}
