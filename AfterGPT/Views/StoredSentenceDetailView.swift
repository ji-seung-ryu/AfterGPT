//
//  ConversationDetailView.swift
//  SwiftUIStarterKitApp
//
//  Created by Ji-Seung on 1/10/24.
//  Copyright © 2024 NexThings. All rights reserved.
//

import SwiftUI

struct StoredSentenceDetailView: View {
    @Binding var sentence: StoredSentence
    
    var body: some View {
        List {
            Section(header: Text("문장 분석")) {
                storedSentenceRow(sentence: sentence.message ).padding(.vertical, 8)
                storedSuggestionRow(sentence: sentence.better_sentence!).padding(.vertical, 8)
                
                storedCommentRow(sentence:sentence.comment!).padding(.vertical, 8)
            }
        }
        .navigationTitle(sentence.title!)
        
    }
}

struct storedSentenceRow: View {
    var sentence: String
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("User")
                    .font(.caption)
                    .foregroundColor(Color.blue)
                
                Spacer()
                
                Button(action: {
                    guard let image = UIImage(systemName: "square.on.square") else {
                        return
                    }
                    let pasteboard = UIPasteboard.general
                    pasteboard.image = image
                    pasteboard.string = sentence
                    showAlert = true
                }) {
                    Image(systemName: "square.on.square")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.gray)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("복사됨"), message: Text("메시지가 클립보드에 복사되었습니다."), dismissButton: .default(Text("확인")))
                }
            }
            Text(sentence)
        }
    }
}

struct storedSuggestionRow: View {
    var sentence: String
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Suggestion")
                    .font(.caption)
                    .foregroundColor(Color.orange)
                
                Spacer()
                
                Button(action: {
                    guard let image = UIImage(systemName: "square.on.square") else {
                        return
                    }
                    let pasteboard = UIPasteboard.general
                    pasteboard.image = image
                    pasteboard.string = sentence
                    showAlert = true
                }) {
                    Image(systemName: "square.on.square")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.gray)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("복사됨"), message: Text("메시지가 클립보드에 복사되었습니다."), dismissButton: .default(Text("확인")))
                }
            }
            Text(sentence)
        }
    }
}

struct storedCommentRow: View {
    var sentence: String
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Comment")
                    .font(.caption)
                    .foregroundColor(Color.pink)
                
                Spacer()
                
                Button(action: {
                    guard let image = UIImage(systemName: "square.on.square") else {
                        return
                    }
                    let pasteboard = UIPasteboard.general
                    pasteboard.image = image
                    pasteboard.string = sentence
                    showAlert = true
                }) {
                    Image(systemName: "square.on.square")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.gray)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("복사됨"), message: Text("메시지가 클립보드에 복사되었습니다."), dismissButton: .default(Text("확인")))
                }
            }
            Text(sentence)
            
            
        }
    }
}
