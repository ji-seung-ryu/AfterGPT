import SwiftUI

struct SentenceDetailView: View {
    @Binding var evaluatedMessage: EvaluatedMessage
    @Binding var sentences: [StoredSentence]
    var conversation_id: UUID
    
    @State private var savedAlert = false // 추가된 부분

    var body: some View {
        
        List {
            Section(header: Text("문장 분석")) {
                sentenceRow(evaluatedMessage: evaluatedMessage).padding(.vertical, 8)
                if evaluatedMessage.message.sender  == "user" {
                    suggestionRow(evaluatedMessage: $evaluatedMessage).padding(.vertical, 8)
                }
                
                if evaluatedMessage.message.sender  == "user" && evaluatedMessage.comment != nil {
                    commentRow(evaluatedMessage: evaluatedMessage).padding(.vertical, 8)
                }
            }
            
            if evaluatedMessage.message.sender  == "user" && evaluatedMessage.comment != nil && evaluatedMessage.better_sentence != nil{
                Section {
                    Button(action: {
                        
                        self.evaluatedMessage.isSaved = true
                        
                        let storedSentence = StoredSentence(
                            id: self.evaluatedMessage.id,
                            conversation_id: self.conversation_id, message_id:evaluatedMessage.id,
                                                            title: self.evaluatedMessage.comment, // appropriate value for your context
                                                            comment: self.evaluatedMessage.comment,
                                                            score: 5,
                                                            
                                                            better_sentence: self.evaluatedMessage.better_sentence!,
                                                            message: self.evaluatedMessage.message.content,
                                                            theme: Theme.random())
                        sentences.insert(storedSentence, at:0)
                        
                        self.savedAlert = true // 저장됨 알림 표시
                    }) {
                        HStack {
                            Image(systemName: evaluatedMessage.isSaved ?? false ? "bookmark.fill" : "bookmark")
                            Text(self.evaluatedMessage.isSaved ?? false ? "저장된 문장" : "저장하기")
                        }
                    }.disabled(self.evaluatedMessage.isSaved ?? false)
                }
            }
            
        }
        .navigationTitle(evaluatedMessage.message.content)
        .alert(isPresented: $savedAlert) {
                    Alert(title: Text("저장됨"), message: Text("저장된 문장에서 위 내용을 확인할 수 있습니다."), dismissButton: .default(Text("확인")))
                } // 저장됨 알림 추가
        
    }
}

struct sentenceRow: View {
    var evaluatedMessage: EvaluatedMessage
    @State private var showAlert = false
    
    
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
                
                Button(action: {
                    guard let image = UIImage(systemName: "square.on.square") else {
                        return
                    }
                    let pasteboard = UIPasteboard.general
                    pasteboard.image = image
                    pasteboard.string = evaluatedMessage.message.content
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
            
            Text(evaluatedMessage.message.content)
            
        }
    }
}

struct suggestionRow: View {
    @Binding var evaluatedMessage: EvaluatedMessage
    @State private var isLoading: Bool = false
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if let betterSentence = evaluatedMessage.better_sentence {
                HStack {
                    Text("Suggestion")
                        .font(.caption)
                        .foregroundColor(Color.orange)
                    
                    Spacer() // 공간을 채우기 위해 Spacer 추가
                    
                    Button(action: {
                        guard let image = UIImage(systemName: "square.on.square") else {
                            return
                        }
                        let pasteboard = UIPasteboard.general
                        pasteboard.image = image
                        pasteboard.string = betterSentence
                        showAlert = true
                    }) {
                        Image(systemName: "square.on.square")
                            .resizable()
                            .frame(width: 18, height:18)
                            .foregroundColor(.gray)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("복사됨"), message: Text("메시지가 클립보드에 복사되었습니다."), dismissButton: .default(Text("확인")))
                    }
                    
                }
                Text(betterSentence)
            } else {
                
                if isLoading{
                    HStack{
                        Spacer()
                        ActivityIndicator().frame(width: 20, height: 20)
                        Spacer()
                    }
                }
                else{
                    Button(action: {
                        generateComment()
                    }) {
                        Text("자연스러운 문장 생성하기")
                    }
                }
            }
            
        }
    }
    
    func generateComment() {
        
        do {
            isLoading = true
            let apiUrl = URL(string: APIManager.apiUrl + "/evaluate") // 실제 API의 엔드포인트로 변경
            
            guard let apiUrl = apiUrl else {
                throw NetworkError.invalidServerConnection
            }
            
            let messageContent = evaluatedMessage.message.content
            let requestBody: [String: Any] = ["message": messageContent]
            
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                do{
                    if error != nil {
                        throw NetworkError.invalidServerConnection
                    }
                    
                    guard let data = data else {
                        throw NetworkError.noDataReceived
                    }
                    
                    let evaluatedMessageWrapper = try decodeResponse(jsonData: data)
                    
                    
                    if let evaluatedMessageData = evaluatedMessageWrapper.body.data(using: .utf8) {
                        let evaluatedMessage = try JSONDecoder().decode(EvaluatedMessage.self, from: evaluatedMessageData)
                        
                        self.isLoading = false
                        self.evaluatedMessage.comment = evaluatedMessage.comment
                        self.evaluatedMessage.better_sentence = evaluatedMessage.better_sentence
                        
                    } else {
                        throw NetworkError.serializationError("Unable to convert evaluated message string to data.")
                    }
                } catch {
                    
                    isLoading = false
                    
                }
            }.resume()
        }
        catch {
            isLoading = false
        }
    }
    
    func decodeResponse(jsonData: Data) throws -> Response {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(Response.self, from: jsonData)
            return response
        } catch {
            throw NetworkError.serializationError(error.localizedDescription)
        }
    }
}


struct commentRow : View{
    var evaluatedMessage: EvaluatedMessage
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if let comment = evaluatedMessage.comment {
                HStack {
                    Text("Comment")
                        .font(.caption)
                        .foregroundColor(Color.pink)
                    
                    Spacer() // 공간을 채우기 위해 Spacer 추가
                    
                    Button(action: {
                        guard let image = UIImage(systemName: "square.on.square") else {
                            return
                        }
                        let pasteboard = UIPasteboard.general
                        pasteboard.image = image
                        pasteboard.string = comment
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
                
                Text(comment)
            }
        }
    }
    
}
