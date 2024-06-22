//
//  NewConversationSheet.swift
//  SwiftUIStarterKitApp
//
//  Created by Ji-Seung on 1/10/24.
//  Copyright © 2024 NexThings. All rights reserved.
//

import SwiftUI


struct NewConversationSheet: View {
    @State private var url: String = ""  // URL을 입력 받을 상태 변수
    @Binding var conversations: [Conversation]
    @Binding var isPresentingNewConversationView: Bool
    @State private var isLoading: Bool = false // Add a state variable for loading indicator
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let appImageDescriptions = ["ChatGPT 어플 좌측 상단에 메뉴바를 눌러주세요.", "공유할 대화를 꾸~욱 눌러주세요.", "Share chat을 눌러주세요.", "하단의 Share link를 눌러주세요.", "하단의 Copy를 눌러주세요.\n이제 공유 URL이 복사되었습니다."]
    let webImageDescriptions = ["우측 상단의 버튼을 눌러주세요.", "Copy Link를 눌러주세요.\n이제 공유 URL이 복사되었습니다."]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("ChatGPT 공유 URL")) {
                    TextField("Enter URL", text: $url)
                        .autocapitalization(.none)
                        .keyboardType(.URL)
                }
                
                Button(action: {
                    guard !isLoading else {
                        // Record has already been added or currently loading, do nothing
                        return
                    }
                    
                    self.isLoading = true // Set loading to true when starting the request
                    
                    do{
                        
                        try sendRecordURLToServer { evaluatedMessages in
                            let conversation = getConversation(evaluatedConversation: evaluatedMessages)
                            
                            conversations.insert(conversation, at:0)
                            
                            self.isPresentingNewConversationView = false
                            self.isLoading = false // Set loading to false after the request completes
                        }
                    } catch {
                        self.alertMessage = error.localizedDescription
                        self.showAlert = true
                        self.isLoading = false
                    }
                    
                    
                    
                }) {
                    if isLoading {
                        VStack {
                            ProgressView()
                                .padding(.bottom, 8)
                            Text("추가되는 중입니다.")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("대화기록 추가하기")
                    }
                }
                
                Section(header: Text("CHATGPT 공유 URL 찾는 법")) {
                    DisclosureGroup("ChatGPT 어플에서") {
                        SwiftyUIScrollView(axis: .horizontal,
                                            numberOfPages: 5, // 이미지-텍스트 쌍의 수
                                            pagingEnabled: true,
                                            pageControlEnabled: true,
                                            hideScrollIndicators: true,
                                           currentPageIndicator: .blue) {
                            HStack(spacing: 0) {
                                ForEach(0..<5, id: \.self) { index in // 이미지-텍스트 쌍의 수에 따라 조정합니다.
                                    VStack {
                                        Text(appImageDescriptions[index])
                                            .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                        
                                        Image("guide\(index)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.main.bounds.width * 0.4) // 이미지 크기 조절
                                            .padding(.vertical, 8)
                                }
                                    .frame(width: UIScreen.main.bounds.width) // 이미지와 텍스트가 화면 가운데에 정렬되도록 가로 길이를 화면 너비로 지정
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height * 0.7)
                    }


                    
                    DisclosureGroup("ChatGPT 웹사이트에서") {
                        SwiftyUIScrollView(axis: .horizontal,
                                            numberOfPages: 2, // 이미지-텍스트 쌍의 수
                                            pagingEnabled: true,
                                            pageControlEnabled: true,
                                            hideScrollIndicators: true,
                                           currentPageIndicator: .blue) {
                            HStack(spacing: 0) {
                                ForEach(0..<2, id: \.self) { index in // 이미지-텍스트 쌍의 수에 따라 조정합니다.
                                    VStack {
                                        Text(webImageDescriptions[index])
                                            .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                        
                                        Image("webguide\(index)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.main.bounds.width * 0.6) // 이미지 크기 조절

                                            .padding(.vertical, 8)
                                        
                                    }
                                    .frame(width: UIScreen.main.bounds.width) // 이미지와 텍스트가 화면 가운데에 정렬되도록 가로 길이를 화면 너비로 지정
                                }
                            }
                        }.frame(width: UIScreen.main.bounds.width,  height:  UIScreen.main.bounds.height * 0.6)
                        
                        
                    }
                    
                }
                
                
                Section(header: Text("FAQ")) {
                    DisclosureGroup("ChatGPT 공유 URL이 뭔가요?") {
                        Text("ChatGPT 공유 URL은 ChatGPT 모델을 사용하여 생성된 대화 기록을 공유하는 데 사용됩니다. 이는 ChatGPT와의 대화 기록을 가져오는 데 사용됩니다.")
                    }
                    
                    
                    DisclosureGroup("'올바르지 않은 URL입니다.' 라고 뜹니다.") {
                        Text("ChatGPT 공유 URL이 아닌 경우에 발생하는 에러입니다. ChatGPT 공유 URL이 맞는지 확인해주세요. 문제가 지속될 경우 지원팀에 문의해주세요.")
                    }
                    
                    DisclosureGroup("영문 에러 메시지가 나옵니다.") {
                        Text("어플을 처음부터 다시 실행해주세요. 문제가 지속될 경우 지원팀에 문의해주세요.")
                    }
                    
                    
                    DisclosureGroup("모든 ChatGPT 대화기록이 공유되는 건가요?") {
                        Text("아닙니다. ChatGPT 대화기록 중 사용자가 선택한 대화만이 공유됩니다.")
                    }
                    // 추가적인 FAQ 항목들을 여기에 추가할 수 있습니다.
                }
                
                
            }
            .navigationBarItems(leading:
                                    Button("취소하기") {
                isPresentingNewConversationView = false
            }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            )
        }
        
        
        
        
    }
    
    
    
    func sendRecordURLToServer(completion: @escaping (EvaluatedConversation) -> Void) throws{
        guard URL(string: url) != nil else {
            throw NetworkError.invalidURL
        }
        
        // 입력된 URL을 사용하여 기록을 추가하는 로직을 작성
        if let recordURL = URL(string: url) {
            // 기록 추가 로직을 수행
            
            // 서버로 보낼 데이터 준비
            let postData: [String: Any] = ["url": recordURL.absoluteString]
            
            // 서버 URL 설정 (실제 서버 URL로 변경해야 함)
            guard let serverURL = URL(string: APIManager.apiUrl + "/record") else {
                throw NetworkError.invalidServerConnection
            }
            
            // URLSession을 사용하여 POST 요청 보내기
            var request = URLRequest(url: serverURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            do {
                // 데이터를 JSON 형식으로 변환
                let jsonData = try JSONSerialization.data(withJSONObject: postData, options: [])
                
                // 요청에 데이터 추가
                request.httpBody = jsonData
                
                // URLSession 데이터 태스크 실행
                URLSession.shared.dataTask(with: request) { data, response, error in
                    
                    do{
                        if error != nil {
                            throw NetworkError.invalidServerConnection
                        }
                        
                        if let httpResponse = response as? HTTPURLResponse {
                            if httpResponse.statusCode != 200 {
                                throw NetworkError.invalidURL
                            }
                        }
                        
                        if let data = data {
                            let decodedResponse = try decodeResponse(jsonData: data)
                            let conversations = try decodeEvaluatedConversation(jsonString:decodedResponse.body)
                            completion(conversations) // Call completion once decoding is complete
                            
                        } else {
                            throw NetworkError.noDataReceived
                            
                        }
                    } catch{
                        self.alertMessage = error.localizedDescription
                        self.showAlert = true
                        self.isLoading = false
                        
                    }
                }.resume()
            } catch {
                throw NetworkError.serializationError(error.localizedDescription)
            }
        } else {
            throw NetworkError.invalidServerConnection
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
    
    func decodeEvaluatedConversation(jsonString: String) throws -> EvaluatedConversation {
        do {
            guard let jsonData = jsonString.data(using: .utf8) else {
                throw NetworkError.invalidJSONString
            }
            
            // Decode EvaluatedConversation from Data
            let decoder = JSONDecoder()
            let conversation = try decoder.decode(EvaluatedConversation.self, from: jsonData)
            return conversation
        } catch {
            throw NetworkError.serializationError(error.localizedDescription)
        }
    }
    
    func getConversation(evaluatedConversation: EvaluatedConversation) -> Conversation {
        let conversationID = UUID()
        let conversation = Conversation(id: conversationID, title: evaluatedConversation.title, date: evaluatedConversation.date, evaluatedMessages: evaluatedConversation.evaluatedMessages)
        return conversation
    }
    
}
